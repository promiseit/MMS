import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static StorageService? _instance;
  late SharedPreferences _prefs;

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
  }

  // 保存整数
  Future<void> saveInt(String key, int value) async {
    try {
      await _prefs.setInt(key, value);
    } catch (e) {
      // 处理保存失败的情况
    }
  }

  // 保存字符串
  Future<void> saveString(String key, String value) async {
    try {
      await _prefs.setString(key, value);
    } catch (e) {
      // 处理保存失败的情况
    }
  }

  // 获取整数
  int getInt(String key, int defaultValue) {
    try {
      return _prefs.getInt(key) ?? defaultValue;
    } catch (e) {
      return defaultValue;
    }
  }

  // 获取字符串
  String? getString(String key) {
    try {
      return _prefs.getString(key);
    } catch (e) {
      return null;
    }
  }

  // 清除所有数据
  Future<void> clear() async {
    try {
      await _prefs.clear();
    } catch (e) {
      // 处理清除失败的情况
    }
  }
}
