/*
 * Created by Archer on 2022/12/11.
 * Copyright © 2022 Archer. All rights reserved.
 * Github: https://github.com/shrinex
 * Home: http://anyoptional.com
 */

import 'package:dio/dio.dart';
import 'package:levir/src/rest/http/http_message.dart';

/// Encapsulates response body
abstract class HttpInputMessage extends HttpMessage {
  /// Response body, null by default
  dynamic get body => null;

  /// This constructor enables subclasses to provide
  /// const constructors so that they can be used in const expressions
  const HttpInputMessage();
}

/// A type that represents a client HTTP response
abstract class HttpResponse extends HttpInputMessage {
  /// Status code
  int? get statusCode => null;

  /// Status message
  String? get statusMessage => null;

  /// This constructor enables subclasses to provide
  /// const constructors so that they can be used in const expressions
  const HttpResponse();
}

class _HttpResponse implements HttpResponse {
  final Response response;

  const _HttpResponse(this.response);

  @override
  dynamic get body => response.data;

  @override
  int? get statusCode => response.statusCode;

  @override
  String? get statusMessage => response.statusMessage;

  @override
  Map<String, dynamic>? get headers => response.headers.map;
}

extension HttpResponseConvertible on Response {
  HttpResponse asHttpResponse() => _HttpResponse(this);
}
