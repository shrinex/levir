/*
 * Created by Archer on 2022/12/10.
 * Copyright © 2022 Archer. All rights reserved.
 * Github: https://github.com/shrinex
 * Home: http://anyoptional.com
 */

/// A type that can be converted to and from an associated raw value
/// Borrowed from Apple/Swift
abstract class RawRepresentable<T> {
  /// The corresponding value of the raw type
  T get rawValue;
}

/// Since dart does not support something like `E extends Enum & RawRepresentable`
/// So I have to do this...
/// See https://github.com/dart-lang/language/issues/2709
abstract class RawEnum<T> extends Enum implements RawRepresentable<T> {}

/// Access enum values by rawValue
extension EnumByRawValue<T, E extends RawEnum<T>> on Iterable<E> {
  /// Finds the enum value in this list with [rawValue],
  /// or null if specified rawValue does not match
  E? byRawValue(T rawValue) {
    for (final value in this) {
      if (value.rawValue == rawValue) {
        return value;
      }
    }
    return null;
  }

  /// Finds the enum value in this list with [rawValue],
  /// or throws error if specified rawValue does not match
  E byRequiredRawValue(T rawValue) {
    final result = byRawValue(rawValue);
    if (result == null) {
      throw ArgumentError.value(
        rawValue,
        "rawValue",
        "No enum value with that rawValue",
      );
    }
    return result;
  }
}
