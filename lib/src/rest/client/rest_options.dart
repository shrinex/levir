/*
 * Created by Archer on 2022/12/10.
 * Copyright © 2022 Archer. All rights reserved.
 * Github: https://github.com/shrinex
 * Home: http://anyoptional.com
 */

/// A type that knows the location of Shrine API
abstract class RestOptions {
  /// Base url for HTTP request
  String get baseUrl;

  /// How long should we wait before receiving a reply
  Duration get sendTimeout;

  /// How long should we wait before receiving reply completely
  Duration get readTimeout;

  /// How long should we wait before connecting to server
  Duration get connectTimeout;

  factory RestOptions({
    required String baseUrl,
    Duration sendTimeout = const Duration(seconds: 2),
    Duration readTimeout = const Duration(seconds: 4),
    Duration connectTimeout = const Duration(seconds: 2),
  }) =>
      _RestOptions(
        baseUrl,
        sendTimeout,
        readTimeout,
        connectTimeout,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is RestOptions &&
        other.baseUrl == baseUrl &&
        other.sendTimeout == sendTimeout &&
        other.readTimeout == readTimeout &&
        other.connectTimeout == connectTimeout;
  }

  @override
  int get hashCode => Object.hash(
        baseUrl,
        sendTimeout,
        readTimeout,
        connectTimeout,
      );
}

class _RestOptions with RestOptions {
  @override
  final String baseUrl;

  @override
  final Duration sendTimeout;

  @override
  final Duration readTimeout;

  @override
  final Duration connectTimeout;

  const _RestOptions(
    this.baseUrl,
    this.sendTimeout,
    this.readTimeout,
    this.connectTimeout,
  );
}
