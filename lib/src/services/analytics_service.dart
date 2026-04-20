import 'package:autism_work_integration_tool/src/services/storage_service.dart';

class AnalyticsService {
  final StorageService _storageService;

  AnalyticsService(this._storageService);

  // 记录游戏使用数据
  Future<void> trackGameUsage(String gameName, int difficulty, bool completed, int score) async {
    try {
      // 获取现有游戏使用数据
      final gameUsageList = await _getGameUsageList();
      
      // 添加新的游戏使用记录
      gameUsageList.add({
        'gameName': gameName,
        'difficulty': difficulty,
        'completed': completed,
        'score': score,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      });
      
      // 保存回存储
      await _storageService.saveString('gameUsageList', gameUsageList.toString());
    } catch (e) {
      // 处理保存失败的情况
    }
  }

  // 记录社交技能练习数据
  Future<void> trackSocialSkillPractice(String skillName, int correctCount, int totalCount) async {
    try {
      // 获取现有社交技能练习数据
      final socialSkillList = await _getSocialSkillList();
      
      // 添加新的练习记录
      socialSkillList.add({
        'skillName': skillName,
        'correctCount': correctCount,
        'totalCount': totalCount,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      });
      
      // 保存回存储
      await _storageService.saveString('socialSkillList', socialSkillList.toString());
    } catch (e) {
      // 处理保存失败的情况
    }
  }

  // 获取游戏使用列表
  Future<List<Map<String, dynamic>>> _getGameUsageList() async {
    try {
      final gameUsageStr = _storageService.getString('gameUsageList');
      if (gameUsageStr == null || gameUsageStr.isEmpty) {
        return [];
      }
      
      // 简单解析字符串为列表
      // 注意：实际应用中应该使用JSON序列化/反序列化
      return [];
    } catch (e) {
      return [];
    }
  }

  // 获取社交技能练习列表
  Future<List<Map<String, dynamic>>> _getSocialSkillList() async {
    try {
      final socialSkillStr = _storageService.getString('socialSkillList');
      if (socialSkillStr == null || socialSkillStr.isEmpty) {
        return [];
      }
      
      // 简单解析字符串为列表
      // 注意：实际应用中应该使用JSON序列化/反序列化
      return [];
    } catch (e) {
      return [];
    }
  }

  // 获取游戏使用统计
  Future<Map<String, dynamic>> getGameUsageStats() async {
    try {
      final gameUsageList = await _getGameUsageList();
      if (gameUsageList.isEmpty) {
        return {
          'totalGames': 0,
          'completedGames': 0,
          'averageScore': 0.0,
          'mostPlayedGame': '',
        };
      }
      
      final totalGames = gameUsageList.length;
      final completedGames = gameUsageList.where((item) => item['completed'] as bool).length;
      final totalScore = gameUsageList.fold(0, (sum, item) => sum + (item['score'] as int));
      final averageScore = totalScore / totalGames;
      
      // 计算最常玩的游戏
      final gameCounts = <String, int>{};
      for (final item in gameUsageList) {
        final gameName = item['gameName'] as String;
        gameCounts[gameName] = (gameCounts[gameName] ?? 0) + 1;
      }
      
      String mostPlayedGame = '';
      int maxCount = 0;
      gameCounts.forEach((game, count) {
        if (count > maxCount) {
          maxCount = count;
          mostPlayedGame = game;
        }
      });
      
      return {
        'totalGames': totalGames,
        'completedGames': completedGames,
        'averageScore': averageScore,
        'mostPlayedGame': mostPlayedGame,
      };
    } catch (e) {
      return {
        'totalGames': 0,
        'completedGames': 0,
        'averageScore': 0.0,
        'mostPlayedGame': '',
      };
    }
  }

  // 获取社交技能练习统计
  Future<Map<String, dynamic>> getSocialSkillStats() async {
    try {
      final socialSkillList = await _getSocialSkillList();
      if (socialSkillList.isEmpty) {
        return {
          'totalPractice': 0,
          'averageAccuracy': 0.0,
          'mostPracticedSkill': '',
        };
      }
      
      final totalPractice = socialSkillList.length;
      final totalCorrect = socialSkillList.fold(0, (sum, item) => sum + (item['correctCount'] as int));
      final totalQuestions = socialSkillList.fold(0, (sum, item) => sum + (item['totalCount'] as int));
      final averageAccuracy = totalQuestions > 0 ? totalCorrect / totalQuestions : 0.0;
      
      // 计算最常练习的技能
      final skillCounts = <String, int>{};
      for (final item in socialSkillList) {
        final skillName = item['skillName'] as String;
        skillCounts[skillName] = (skillCounts[skillName] ?? 0) + 1;
      }
      
      String mostPracticedSkill = '';
      int maxCount = 0;
      skillCounts.forEach((skill, count) {
        if (count > maxCount) {
          maxCount = count;
          mostPracticedSkill = skill;
        }
      });
      
      return {
        'totalPractice': totalPractice,
        'averageAccuracy': averageAccuracy,
        'mostPracticedSkill': mostPracticedSkill,
      };
    } catch (e) {
      return {
        'totalPractice': 0,
        'averageAccuracy': 0.0,
        'mostPracticedSkill': '',
      };
    }
  }
}
