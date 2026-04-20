import 'package:flutter_test/flutter_test.dart';
import 'package:autism_work_integration_tool/src/services/storage_service.dart';

void main() {
  group('StorageService', () {
    late StorageService storageService;

    setUp(() async {
      storageService = await StorageService.instance;
    });

    test('should save and get integer', () async {
      // 保存整数
      await storageService.saveInt('testInt', 123);
      // 获取整数
      final value = storageService.getInt('testInt', 0);
      expect(value, equals(123));
    });

    test('should return default value when key not found', () {
      // 获取不存在的键，应该返回默认值
      final value = storageService.getInt('nonExistentKey', 999);
      expect(value, equals(999));
    });

    test('should save and get string', () async {
      // 保存字符串
      await storageService.saveString('testString', 'Hello, World!');
      // 获取字符串
      final value = storageService.getString('testString');
      expect(value, equals('Hello, World!'));
    });

    test('should return null when string key not found', () {
      // 获取不存在的键，应该返回null
      final value = storageService.getString('nonExistentStringKey');
      expect(value, isNull);
    });
  });
}
