import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../constants/constants.dart' show HiveKeys;
import 'package:packages/packages.dart';
import 'package:preferences/preferences.dart';

/// Cache Manager
/// A simple and efficient interface for persisting and retrieving state changes.
///
/// Supported data types:
/// `List`, `Map`, `DateTime`, `BigInt`, and `Uint8List`.
abstract interface class CacheManager {
  bool get isInitialized;

  /// Retrieves a value associated with the [key].
  /// Retrieves a value associated with the [key].
  /// Returns the value cast to type [T].
  // Future<T?> read<T>(String key);
  FutureOr<T?>? read<T>(String key);

  /// Persists a key-value pair.
  /// Supports `List`, `Map`, `DateTime`, `BigInt`, and `Uint8List` as value types.
  /// Other types may result in an error.
  Future<void>? write(String key, dynamic value);

  /// Deletes a value by its [key].
  Future<void>? delete(String key);

  /// Clears all cached data.
  Future<void>? clearAll();

  /// Compacts the cache to optimize storage.
  Future<void>? compact();

  /// Closes the cache manager and releases any resources.
  Future<void>? close();
}

/// Implementation of [CacheManager] that uses `Hive` to persist and retrieve state changes from the local device.
final class CacheManagerImpl implements CacheManager {
  static CacheManagerImpl? _singleton;
  static late Box _box;

  CacheManagerImpl._();

  factory CacheManagerImpl() {
// if null then throw error //TODO ADD
    _singleton ??= CacheManagerImpl._();
    return _singleton!;
  }

  static void _isolateMain(
      ({
        RootIsolateToken? rootIsolateToken,
        FlavorConfig? config
      }) record) async {
    BackgroundIsolateBinaryMessenger.ensureInitialized(
        record.rootIsolateToken!);
    final config = record.config ?? FlavorConfig();
    await Hive.initFlutter();
    await _openBox(config);
  }

  /// Initializes the cache manager. Should be called before using the instance.
  ///
  /// [encrypt] specifies whether to encrypt the stored data.
  /// [encryptKey] is the key used for encryption.
  static Future<CacheManagerImpl> setup({FlavorConfig? config}) async {
    config ??= FlavorConfig();
    if (_singleton == null) {
      RootIsolateToken? rootIsolateToken = RootIsolateToken.instance;
      compute(
          _isolateMain, (rootIsolateToken: rootIsolateToken, config: config));
      // await Hive.initFlutter(); //here was the error use await

      // _box = await _openBox(config);

      _singleton = CacheManagerImpl._();
    }

    return _singleton!;
  }

  static _openBox(FlavorConfig? config) => Hive.openBox(
        HiveKeys.globalkey,
        // ignore: deprecated_member_use
        encryptionKey: config!.iscacheEncrypted
            ? config.cacheEncryptKey.codeUnits
            : null, // i found a bug in  encryptionCipher when it is null , but that can be resolved by using this Depricated Stuff encryptionKey, very usefull
      );

  @override
  Future<void>? delete(String key) =>
      (isInitialized && _box.isOpen) ? _box.delete(key) : null;

  @override
  // Future<T?> read<T>(String key)
  FutureOr<T?>? read<T>(String key) =>
      (isInitialized && _box.isOpen) ? _box.get(key) as FutureOr<T?>? : null;

  @override
  Future<void>? write(String key, dynamic value) =>
      (isInitialized && _box.isOpen) ? _box.put(key, value) : null;

  @override
  Future<void>? compact() =>
      (isInitialized && _box.isOpen) ? _box.compact() : null;

  @override
  Future<void>? clearAll() =>
      (isInitialized && _box.isOpen) ? _box.clear() : null;

  @override
  Future<void>? close() => (isInitialized && _box.isOpen) ? _box.close() : null;

  @override
  bool get isInitialized => _singleton != null;
}
