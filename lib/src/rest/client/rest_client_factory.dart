/*
 * Created by Archer on 2022/12/15.
 * Copyright © 2022 Archer. All rights reserved.
 * Github: https://github.com/shrinex
 * Home: http://anyoptional.com
 */

import 'package:levir/src/rest/client/rest_client.dart';

/// A factory that produces [RestClient]
abstract class RestClientFactory {
  T createRestClient<T extends RestClient>();
}

/// A [RestClientFactory] that always returns the same [RestClient]
class CachedRestClientFactory implements RestClientFactory {
  RestClient? _restClient;

  final RestClientFactory delegate;

  CachedRestClientFactory({required this.delegate});

  @override
  T createRestClient<T extends RestClient>() {
    return (_restClient ??= delegate.createRestClient()) as T;
  }

  static RestClientFactory wrapIfPossible(RestClientFactory delegate) {
    if (delegate is CachedRestClientFactory) {
      return delegate;
    }
    return CachedRestClientFactory(delegate: delegate);
  }
}
