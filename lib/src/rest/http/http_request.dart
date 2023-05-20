/*
 * Created by Archer on 2022/12/10.
 * Copyright © 2022 Archer. All rights reserved.
 * Github: https://github.com/shrinex
 * Home: http://anyoptional.com
 */

import 'package:levir/src/rest/http/http_message.dart';
import 'package:levir/src/rest/http/http_method.dart';

/// Encapsulates request body
abstract class HttpOutputMessage extends HttpMessage {
  /// Request body, null by default
  dynamic get body => null;

  /// This constructor enables subclasses to provide
  /// const constructors so that they can be used in const expressions
  const HttpOutputMessage();
}

/// A type that represents a client HTTP request
abstract class HttpRequest extends HttpOutputMessage {
  /// Request path
  String get path;

  /// Request method
  HttpMethod get method;

  /// Optional base url, overrides [RestOptions.baseUrl] if present
  String? get baseUrl => null;

  /// Optional read timeout, overrides [RestOptions.sendTimeout] if present
  Duration? get sendTimeout => null;

  /// Optional read timeout, overrides [RestOptions.readTimeout] if present
  Duration? get readTimeout => null;

  /// Optional connect timeout, overrides [RestOptions.connectTimeout] if present
  Duration? get connectTimeout => null;

  /// Query parameters
  Map<String, dynamic>? get queryParams => {};

  /// This constructor enables subclasses to provide
  /// const constructors so that they can be used in const expressions
  const HttpRequest();
}

/// Used for predefined requests
class ClientHttpRequest implements HttpRequest {
  @override
  final String path;

  @override
  final dynamic body;

  @override
  final String? baseUrl;

  @override
  final Duration? sendTimeout;

  @override
  final Duration? readTimeout;

  @override
  final HttpMethod method;

  @override
  final Duration? connectTimeout;

  @override
  final Map<String, dynamic>? headers;

  @override
  final Map<String, dynamic>? queryParams;

  const ClientHttpRequest({
    this.body,
    this.baseUrl,
    this.headers,
    this.queryParams,
    this.sendTimeout,
    this.readTimeout,
    this.connectTimeout,
    required this.path,
    required this.method,
  });

  ClientHttpRequest copyWith({
    String? path,
    dynamic body,
    String? baseUrl,
    HttpMethod? method,
    Duration? sendTimeout,
    Duration? readTimeout,
    Duration? connectTimeout,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
  }) {
    return ClientHttpRequest(
      path: path ?? this.path,
      body: body ?? this.body,
      method: method ?? this.method,
      baseUrl: baseUrl ?? this.baseUrl,
      headers: headers ?? this.headers,
      queryParams: queryParams ?? this.queryParams,
      sendTimeout: sendTimeout ?? this.sendTimeout,
      readTimeout: readTimeout ?? this.readTimeout,
      connectTimeout: connectTimeout ?? this.connectTimeout,
    );
  }
}
