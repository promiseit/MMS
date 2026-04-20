import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  static StorageService? _instance;
  late SharedPreferences _prefs;
  late FlutterSecureStorage _secureStorage;

  StorageService._privateConstructor();

  static Future<StorageService> get instance async {
    if (_instance == null) {
      _instance = StorageService._privateConstructor();
      await _instance!._init();
    }
    return _instance!;
  }

  Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();
    _secureStorage = const FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
      iOptions: IOSOptions(
        accessibility: KeychainAccessibility.first_unlock,
      ),
    );
  }

  Future<void> saveInt(String key, int value) async {
    try {
      await _prefs.setInt(key, value);
    } catch (e) {
      throw StorageException('保存整数失败: $key', e);
    }
  }

  Future<void> saveString(String key, String value) async {
    try {
      await _prefs.setString(key, value);
    } catch (e) {
      throw StorageException('保存字符串失败: $key', e);
    }
  }

  Future<void> saveBool(String key, bool value) async {
    try {
      await _prefs.setBool(key, value);
    } catch (e) {
      throw StorageException('保存布尔值失败: $key', e);
    }
  }

  int getInt(String key, int defaultValue) {
    try {
      return _prefs.getInt(key) ?? defaultValue;
    } catch (e) {
      return defaultValue;
    }
  }

  String? getString(String key) {
    try {
      return _prefs.getString(key);
    } catch (e) {
      return null;
    }
  }

  bool getBool(String key, bool defaultValue) {
    try {
      return _prefs.getBool(key) ?? defaultValue;
    } catch (e) {
      return defaultValue;
    }
  }

  Future<void> saveSecureString(String key, String value) async {
    try {
      await _secureStorage.write(key: key, value: value);
    } catch (e) {
      throw StorageException('安全保存字符串失败: $key', e);
    }
  }

  Future<String?> getSecureString(String key) async {
    try {
      return await _secureStorage.read(key: key);
    } catch (e) {
      return null;
    }
  }

  Future<void> deleteSecureString(String key) async {
    try {
      await _secureStorage.delete(key: key);
    } catch (e) {
    }
  }

  Future<void> clear() async {
    try {
      await _prefs.clear();
      await _secureStorage.deleteAll();
    } catch (e) {
      throw StorageException('清除数据失败', e);
    }
  }
}

class StorageException implements Exception {
  final String message;
  final Object? cause;

  StorageException(this.message, [this.cause]);

  @override
  String toString() => message;
}
