/*
 * Created by Archer on 2022/12/15.
 * Copyright © 2022 Archer. All rights reserved.
 * Github: https://github.com/shrinex
 * Home: http://anyoptional.com
 */

import 'package:levir/src/rest/client/dio_rest_client.dart';
import 'package:levir/src/rest/client/rest_client.dart';
import 'package:levir/src/rest/client/rest_client_factory.dart';
import 'package:levir/src/rest/client/rest_options.dart';

class DioRestClientFactory implements RestClientFactory {
  final RestOptions restOptions;

  const DioRestClientFactory({
    required this.restOptions,
  });

  @override
  T createRestClient<T extends RestClient>() {
    return DioRestClient.using(restOptions: restOptions) as T;
  }
}
