/*
 * Created by Archer on 2022/12/10.
 * Copyright © 2022 Archer. All rights reserved.
 * Github: https://github.com/shrinex
 * Home: http://anyoptional.com
 */

import 'package:levir/src/lang/raw_representable.dart';

/// dart enumeration of HTTP request methods
enum HttpMethod implements RawEnum<String> {
  get('GET'),
  head('HEAD'),
  post('POST'),
  put('PUT'),
  patch('PATCH'),
  delete('DELETE'),
  options('OPTIONS'),
  trace('TRACE'),
  ;

  @override
  final String rawValue;

  const HttpMethod(
    this.rawValue,
  );
}
