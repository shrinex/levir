/*
 * Created by Archer on 2022/12/15.
 * Copyright © 2022 Archer. All rights reserved.
 * Github: https://github.com/shrinex
 * Home: http://anyoptional.com
 */

import 'package:levir/src/rest/http/http_request.dart';
import 'package:levir/src/rest/http/http_response.dart';

/// A type that knows how to make HTTP request
abstract class RestClient {
  /// Execute the specified HTTP request asynchronously
  Future<HttpResponse> execute(HttpRequest request);
}
