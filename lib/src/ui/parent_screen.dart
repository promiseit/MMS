import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:autism_work_integration_tool/src/providers/game_provider.dart';

class ParentScreen extends StatelessWidget {
  const ParentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('家长中心'),
        backgroundColor: const Color(0xFF4CAF50),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            const Text(
              '家长中心',
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 40),
            
            // 孩子学习情况
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
                    '学习情况',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatItem('游戏次数', gameProvider.totalGamesPlayed.toString()),
                      _buildStatItem('总得分', gameProvider.totalScore.toString()),
                      _buildStatItem('等级', gameProvider.level.toString()),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            // 游戏进度
            const Text(
              '游戏进度',
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
                  _buildGameProgress('文字排序游戏', gameProvider.gameLevels['文字排序游戏'] ?? 0),
                  _buildGameProgress('数字计算游戏', gameProvider.gameLevels['数字计算游戏'] ?? 0),
                  _buildGameProgress('英文拼接游戏', gameProvider.gameLevels['英文拼接游戏'] ?? 0),
                  _buildGameProgress('编程游戏', gameProvider.gameLevels['编程游戏'] ?? 0),
                  _buildGameProgress('混合模式游戏', gameProvider.gameLevels['混合模式游戏'] ?? 0),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            // 家长设置
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
                    '家长设置',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    leading: const Icon(Icons.timer, size: 24.0),
                    title: const Text('每日游戏时间限制', style: TextStyle(fontSize: 16.0)),
                    trailing: const Icon(Icons.arrow_forward),
                    onTap: () {
                      // 导航到时间限制设置
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.lock, size: 24.0),
                    title: const Text('家长密码设置', style: TextStyle(fontSize: 16.0)),
                    trailing: const Icon(Icons.arrow_forward),
                    onTap: () {
                      // 导航到密码设置
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.notifications, size: 24.0),
                    title: const Text('学习提醒设置', style: TextStyle(fontSize: 16.0)),
                    trailing: const Icon(Icons.arrow_forward),
                    onTap: () {
                      // 导航到提醒设置
                    },
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

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4CAF50),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14.0,
            color: Color(0xFF666666),
          ),
        ),
      ],
    );
  }

  Widget _buildGameProgress(String gameName, int level) {
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
                '进度: $level/5',
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Color(0xFF666666),
                ),
              ),
              Text(
                '${(level / 5 * 100).toInt()}%',
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
}
