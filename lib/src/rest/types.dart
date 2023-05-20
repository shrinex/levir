/*
 * Created by Archer on 2022/12/10.
 * Copyright © 2022 Archer. All rights reserved.
 * Github: https://github.com/shrinex
 * Home: http://anyoptional.com
 */

import 'package:levir/src/rest/http/http_request.dart';
import 'package:levir/src/rest/http/http_response.dart';

/// Handler method for code that operates on a [HttpRequest]
/// Allows manipulating the request headers, and write to the request body
typedef RequestHandler = HttpRequest Function(HttpRequest);

/// Strategy handler method used to adapt [Exception] to [ErrorEnvelope]
typedef ExceptionHandler = ErrorEnvelope Function(Exception);

/// Strategy interface used by the [Service] to determine
/// whether a particular response has an error or not
abstract class ResponseErrorHandler {
  /// Indicate whether the given response has any errors
  bool hasError(HttpResponse response);

  /// Handle the error in the given request-response pair
  ErrorEnvelope handleError(HttpRequest request, HttpResponse response);
}

/// A type that encapsulates context about an error
class ErrorEnvelope {
  /// Internal server error
  static const internal = ErrorEnvelope(
    code: -1,
    message: "服务器开小差了，请稍后再试",
  );

  static const network = ErrorEnvelope(
    code: -2,
    message: "似乎断开了与互联网的连接",
  );

  final int code;
  final String message;

  const ErrorEnvelope({
    required this.code,
    required this.message,
  });

  @override
  String toString() => message;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ErrorEnvelope &&
          runtimeType == other.runtimeType &&
          code == other.code &&
          message == other.message;

  @override
  int get hashCode => code.hashCode ^ message.hashCode;
}
