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
      case DioErrorType.connectTimeout:
        return ErrorEnvelope.network;
      case DioErrorType.receiveTimeout:
        return ErrorEnvelope.internal;
      case DioErrorType.response:
        return ErrorEnvelope(
          code: ex.response?.statusCode ?? ErrorEnvelope.internal.code,
          message: ex.response?.statusMessage ?? ErrorEnvelope.internal.message,
        );
      default:
        return ErrorEnvelope(
          code: ErrorEnvelope.internal.code,
          message: ex.message,
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

    if (response.statusCode == null ||
        response.statusCode! < 200 ||
        response.statusCode! >= 300) {
      return true;
    }

    return false;
  }

  @override
  ErrorEnvelope handleError(HttpRequest request, HttpResponse response) {
    if (response.statusCode == null ||
        response.statusCode! < 200 ||
        response.statusCode! >= 300) {
      return ErrorEnvelope(
        code: response.statusCode ?? ErrorEnvelope.internal.code,
        message: response.statusMessage ?? ErrorEnvelope.internal.message,
      );
    }

    return ErrorEnvelope.internal;
  }
}
