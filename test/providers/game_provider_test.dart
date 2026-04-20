import 'package:flutter_test/flutter_test.dart';
import 'package:autism_work_integration_tool/src/providers/game_provider.dart';
import 'package:autism_work_integration_tool/src/services/service_locator.dart';

void main() {
  setUpAll(() async {
    // 初始化服务定位器
    await serviceLocator.init();
  });

  group('GameProvider', () {
    late GameProvider gameProvider;

    setUp(() {
      gameProvider = GameProvider();
    });

    test('should initialize with default values', () {
      expect(gameProvider.totalGamesPlayed, equals(0));
      expect(gameProvider.totalScore, equals(0));
      expect(gameProvider.level, equals(1));
      expect(gameProvider.gameScores, isEmpty);
      expect(gameProvider.gameLevels, isEmpty);
    });

    test('should update game score and level', () async {
      // 初始状态
      expect(gameProvider.totalScore, equals(0));
      expect(gameProvider.level, equals(1));

      // 更新游戏分数
      gameProvider.updateGameScore('编程游戏', 1000);

      // 验证分数和等级更新
      expect(gameProvider.totalScore, equals(1000));
      expect(gameProvider.level, equals(2)); // 每1000分升一级
      expect(gameProvider.gameScores['编程游戏'], equals(1000));
    });

    test('should update game level', () async {
      // 初始状态
      expect(gameProvider.gameLevels, isEmpty);

      // 更新游戏等级
      gameProvider.updateGameLevel('编程游戏', 3);

      // 验证等级更新
      expect(gameProvider.gameLevels['编程游戏'], equals(3));

      // 再次更新相同等级，应该不会改变
      gameProvider.updateGameLevel('编程游戏', 3);
      expect(gameProvider.gameLevels['编程游戏'], equals(3));

      // 更新更高等级，应该会改变
      gameProvider.updateGameLevel('编程游戏', 4);
      expect(gameProvider.gameLevels['编程游戏'], equals(4));
    });

    test('should reset progress', () async {
      // 先更新一些数据
      gameProvider.updateGameScore('编程游戏', 500);
      gameProvider.updateGameLevel('编程游戏', 2);

      // 验证数据已更新
      expect(gameProvider.totalScore, equals(500));
      expect(gameProvider.gameScores['编程游戏'], equals(500));
      expect(gameProvider.gameLevels['编程游戏'], equals(2));

      // 重置进度
      await gameProvider.resetProgress();

      // 验证数据已重置
      expect(gameProvider.totalGamesPlayed, equals(0));
      expect(gameProvider.totalScore, equals(0));
      expect(gameProvider.level, equals(1));
      expect(gameProvider.gameScores, isEmpty);
      expect(gameProvider.gameLevels, isEmpty);
    });
  });
}
