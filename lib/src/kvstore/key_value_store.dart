/*
 * Created by Archer on 2022/12/10.
 * Copyright © 2022 Archer. All rights reserved.
 * Github: https://github.com/shrinex
 * Home: http://anyoptional.com
 */

import 'package:shared_preferences/shared_preferences.dart';

abstract class KeyValueStore {
  /// Reads a value from persistent storage, throwing an exception if it's not a
  /// bool
  bool? getBool(String key);

  /// Reads a value from persistent storage, throwing an exception if it's not
  /// an int
  int? getInt(String key);

  /// Reads a value from persistent storage, throwing an exception if it's not a
  /// double
  double? getDouble(String key);

  /// Reads a value from persistent storage, throwing an exception if it's not a
  /// String
  String? getString(String key);

  /// Saves a boolean [value] to persistent storage in the background
  Future<bool> setBool(String key, bool value);

  /// Saves an integer [value] to persistent storage in the background
  Future<bool> setInt(String key, int value);

  /// Saves a double [value] to persistent storage in the background
  ///
  /// Android doesn't support storing doubles, so it will be stored as a float
  Future<bool> setDouble(String key, double value);

  /// Saves a string [value] to persistent storage in the background
  ///
  /// Note: Due to limitations in Android's SharedPreferences,
  /// values cannot start with any one of the following:
  ///
  /// - 'VGhpcyBpcyB0aGUgcHJlZml4IGZvciBhIGxpc3Qu'
  /// - 'VGhpcyBpcyB0aGUgcHJlZml4IGZvciBCaWdJbnRlZ2Vy'
  /// - 'VGhpcyBpcyB0aGUgcHJlZml4IGZvciBEb3VibGUu'
  Future<bool> setString(String key, String value);

  /// Returns true if persistent storage the contains the given [key]
  bool containsKey(String key);

  /// Removes an entry from persistent storage
  Future<bool> remove(String key);
}

class _KeyValueStore implements KeyValueStore {
  final SharedPreferences _prefs;

  const _KeyValueStore(SharedPreferences prefs) : _prefs = prefs;

  @override
  bool? getBool(String key) => _prefs.getBool(key);

  @override
  int? getInt(String key) => _prefs.getInt(key);

  @override
  double? getDouble(String key) => _prefs.getDouble(key);

  @override
  String? getString(String key) => _prefs.getString(key);

  @override
  Future<bool> setBool(String key, bool value) => _prefs.setBool(key, value);

  @override
  Future<bool> setInt(String key, int value) => _prefs.setInt(key, value);

  @override
  Future<bool> setDouble(String key, double value) =>
      _prefs.setDouble(key, value);

  @override
  Future<bool> setString(String key, String value) =>
      _prefs.setString(key, value);

  @override
  bool containsKey(String key) => _prefs.containsKey(key);

  @override
  Future<bool> remove(String key) => _prefs.remove(key);
}

extension KeyValueStoreConvertible on SharedPreferences {
  /// Adapt SharedPreferences to KeyValueStore
  KeyValueStore asKeyValueStore() => _KeyValueStore(this);
}
