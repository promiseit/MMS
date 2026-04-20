import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:autism_work_integration_tool/src/providers/game_provider.dart';
import 'package:autism_work_integration_tool/src/ui/history_screen.dart';
import 'package:autism_work_integration_tool/src/ui/social_skills_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('我的'),
        backgroundColor: const Color(0xFF4CAF50),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            // 用户头像
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFE8F5E9),
                border: Border.all(
                  color: const Color(0xFF4CAF50),
                  width: 3.0,
                ),
              ),
              child: const Icon(
                Icons.person,
                size: 64.0,
                color: Color(0xFF4CAF50),
              ),
            ),
            const SizedBox(height: 24),
            // 用户名
            const Text(
              '用户',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 8),
            // 用户ID
            const Text(
              'ID: 123456',
              style: TextStyle(
                fontSize: 16.0,
                color: Color(0xFF666666),
              ),
            ),
            const SizedBox(height: 40),
            // 统计信息
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem('游戏次数', gameProvider.totalGamesPlayed.toString()),
                _buildStatItem('总得分', gameProvider.totalScore.toString()),
                _buildStatItem('等级', gameProvider.level.toString()),
              ],
            ),
            const SizedBox(height: 40),
            // 功能列表
            ListView(
              shrinkWrap: true,
              children: [
                ListTile(
                  leading: const Icon(Icons.history, size: 28),
                  title: const Text('练习历史', style: TextStyle(fontSize: 18.0)),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HistoryScreen()),
                    );
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.emoji_events, size: 28),
                  title: const Text('成就徽章', style: TextStyle(fontSize: 18.0)),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    // 导航到成就徽章
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.people, size: 28),
                  title: const Text('社交技能练习', style: TextStyle(fontSize: 18.0)),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SocialSkillsScreen()),
                    );
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.share, size: 28),
                  title: const Text('成就分享', style: TextStyle(fontSize: 18.0)),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    // 导航到成就分享
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.security, size: 28),
                  title: const Text('账户安全', style: TextStyle(fontSize: 18.0)),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    // 导航到账户安全
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.logout, size: 28),
                  title: const Text('退出登录', style: TextStyle(fontSize: 18.0)),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    // 退出登录
                  },
                ),
              ],
            ),
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
}
