/*
 * Created by Archer on 2022/12/11.
 * Copyright © 2022 Archer. All rights reserved.
 * Github: https://github.com/shrinex
 * Home: http://anyoptional.com
 */

import 'package:dio/dio.dart';
import 'package:levir/src/rest/http/http_request.dart';
import 'package:levir/src/rest/http/http_response.dart';
import 'package:levir/src/rest/types.dart';

ErrorEnvelope defaultExceptionHandler(Exception ex) {
  if (ex is DioError) {
    switch (ex.type) {
      case DioErrorType.sendTimeout:
      case DioErrorType.connectionError:
      case DioErrorType.connectionTimeout:
        return ErrorEnvelope.network;
      case DioErrorType.receiveTimeout:
        return ErrorEnvelope.internal;
      case DioErrorType.badResponse:
        return ErrorEnvelope(
          code: ex.response?.statusCode ?? ErrorEnvelope.internal.code,
          message: ex.response?.statusMessage ?? ErrorEnvelope.internal.message,
        );
      default:
        return ErrorEnvelope(
          code: ErrorEnvelope.internal.code,
          message: ex.message ?? ErrorEnvelope.internal.message,
        );
    }
  }

  return ErrorEnvelope.internal;
}

HttpRequest defaultRequestHandler(HttpRequest request) => request;

const defaultResponseErrorHandler = _ResponseErrorHandler();

class _ResponseErrorHandler implements ResponseErrorHandler {
  const _ResponseErrorHandler();

  @override
  bool hasError(HttpResponse response) {
    if (response.body == null) {
      return true;
    }

    return false;
  }

  @override
  ErrorEnvelope handleError(HttpRequest request, HttpResponse response) {
    return ErrorEnvelope.internal;
  }
}
