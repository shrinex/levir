/*
 * Created by Archer on 2022/12/10.
 * Copyright © 2022 Archer. All rights reserved.
 * Github: https://github.com/shrinex
 * Home: http://anyoptional.com
 */

import 'package:levir/src/rest/client/auth/bearer_token.dart';
import 'package:levir/src/rest/client/rest_client.dart';
import 'package:levir/src/rest/http/http_request.dart';
import 'package:levir/src/rest/srv/defaults.dart';
import 'package:levir/src/rest/types.dart';
import 'package:rxdart/rxdart.dart';

/// A type that knows how to fetch Shrine data
abstract class Service {
  /// Used to fire HTTP request
  RestClient get restClient;

  /// Used to authenticate Shrine api
  BearerToken? get bearerToken;

  /// Factory method that helps create [Service] instance
  factory Service.using({
    BearerToken? bearerToken,
    required RestClient restClient,
  }) =>
      _Service(
        restClient: restClient,
        bearerToken: bearerToken,
      );

  /// Returns a new service with the [Service] token replaced
  Service login(BearerToken bearerToken) {
    return Service.using(
      restClient: restClient,
      bearerToken: bearerToken,
    );
  }

  /// Returns a new service with the bearer token set to `null`
  Service logout() {
    return Service.using(
      bearerToken: null,
      restClient: restClient,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is Service &&
        other.restClient == restClient &&
        other.bearerToken == bearerToken;
  }

  @override
  int get hashCode => (bearerToken?.hashCode ?? 7) ^ restClient.hashCode;
}

/// Reactive extension for [Service]
extension ReactiveX on Service {
  /// Entry point for making HTTP request
  /// Once called, the method returns a cold but broadcast stream
  Stream<Map<String, dynamic>> observe(
    HttpRequest request, {
    RequestHandler requestHandler = defaultRequestHandler,
    ExceptionHandler exceptionHandler = defaultExceptionHandler,
    ResponseErrorHandler responseErrorHandler = defaultResponseErrorHandler,
  }) {
    final preparedRequest = requestHandler(request);
    return Rx.defer(
      () {
        return Stream.fromFuture(() async {
          try {
            final response = await restClient.execute(preparedRequest);
            if (responseErrorHandler.hasError(response)) {
              return Future<Map<String, dynamic>>.error(
                responseErrorHandler.handleError(preparedRequest, response),
              );
            }
            return Future<Map<String, dynamic>>.value(response.body!);
          } on Exception catch (ex) {
            return Future<Map<String, dynamic>>.error(exceptionHandler(ex));
          }
        }());
      },
      reusable: true,
    );
  }
}

class _Service with Service {
  @override
  final RestClient restClient;

  @override
  final BearerToken? bearerToken;

  _Service({
    this.bearerToken,
    required this.restClient,
  });
}
