import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:autism_work_integration_tool/src/providers/game_provider.dart';

class AssessmentScreen extends StatelessWidget {
  const AssessmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('能力评估'),
        backgroundColor: const Color(0xFF4CAF50),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            const Text(
              '能力评估报告',
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 40),
            
            // 总体评估
            Container(
              padding: const EdgeInsets.all(24.0),
              margin: const EdgeInsets.symmetric(vertical: 16.0),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                  color: const Color(0xFF4CAF50),
                  width: 2.0,
                ),
              ),
              child: Column(
                children: [
                  const Text(
                    '总体评估',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _getOverallAssessment(gameProvider.totalScore),
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: Color(0xFF333333),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            // 游戏能力评估
            const Text(
              '游戏能力评估',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 16),
            
            Expanded(
              child: ListView(
                children: [
                  _buildGameAssessment('文字排序游戏', gameProvider.gameScores['文字排序游戏'] ?? 0, gameProvider.gameLevels['文字排序游戏'] ?? 0),
                  _buildGameAssessment('数字计算游戏', gameProvider.gameScores['数字计算游戏'] ?? 0, gameProvider.gameLevels['数字计算游戏'] ?? 0),
                  _buildGameAssessment('英文拼接游戏', gameProvider.gameScores['英文拼接游戏'] ?? 0, gameProvider.gameLevels['英文拼接游戏'] ?? 0),
                  _buildGameAssessment('编程游戏', gameProvider.gameScores['编程游戏'] ?? 0, gameProvider.gameLevels['编程游戏'] ?? 0),
                  _buildGameAssessment('混合模式游戏', gameProvider.gameScores['混合模式游戏'] ?? 0, gameProvider.gameLevels['混合模式游戏'] ?? 0),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            // 建议
            Container(
              padding: const EdgeInsets.all(24.0),
              margin: const EdgeInsets.symmetric(vertical: 16.0),
              decoration: BoxDecoration(
                color: const Color(0xFFE3F2FD),
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                  color: const Color(0xFF2196F3),
                  width: 2.0,
                ),
              ),
              child: Column(
                children: [
                  const Text(
                    '学习建议',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _getSuggestions(gameProvider),
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Color(0xFF333333),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildGameAssessment(String gameName, int score, int level) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            gameName,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '得分: $score',
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Color(0xFF666666),
                ),
              ),
              Text(
                '等级: $level/5',
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Color(0xFF666666),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: level / 5,
            backgroundColor: const Color(0xFFE0E0E0),
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF4CAF50)),
            minHeight: 8.0,
          ),
        ],
      ),
    );
  }

  String _getOverallAssessment(int totalScore) {
    if (totalScore >= 2000) {
      return '优秀：你已经掌握了职场所需的核心技能，可以独立应对工作中的各种挑战。';
    } else if (totalScore >= 1000) {
      return '良好：你已经具备了基本的职场技能，继续努力可以进一步提升。';
    } else if (totalScore >= 500) {
      return '一般：你正在学习职场技能，需要更多的练习来提高。';
    } else {
      return '入门：你刚刚开始学习职场技能，建议从基础开始，逐步提高。';
    }
  }

  String _getSuggestions(GameProvider gameProvider) {
    List<String> suggestions = [];
    
    if ((gameProvider.gameLevels['文字排序游戏'] ?? 0) < 3) {
      suggestions.add('建议多练习文字排序游戏，提高工作流程的理解和执行能力。');
    }
    
    if ((gameProvider.gameLevels['数字计算游戏'] ?? 0) < 3) {
      suggestions.add('建议多练习数字计算游戏，提高办公数据处理能力。');
    }
    
    if ((gameProvider.gameLevels['英文拼接游戏'] ?? 0) < 3) {
      suggestions.add('建议多练习英文拼接游戏，提高职场英文词汇量。');
    }
    
    if ((gameProvider.gameLevels['编程游戏'] ?? 0) < 3) {
      suggestions.add('建议多练习编程游戏，提高工作自动化能力。');
    }
    
    if ((gameProvider.gameLevels['混合模式游戏'] ?? 0) < 3) {
      suggestions.add('建议多练习混合模式游戏，提高综合任务处理能力。');
    }
    
    if (suggestions.isEmpty) {
      return '你已经在所有游戏中表现良好，建议尝试更高难度的挑战，进一步提升自己的能力。';
    }
    
    return suggestions.join(' ');
  }
}
