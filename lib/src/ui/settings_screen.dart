import 'package:flutter/material.dart';
import 'package:autism_work_integration_tool/src/ui/accessibility_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('设置'),
        backgroundColor: const Color(0xFF4CAF50),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            const Text(
              '设置',
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 40),
            ListView(
              shrinkWrap: true,
              children: [
                ListTile(
                  leading: const Icon(Icons.accessibility, size: 28),
                  title: const Text('个性化设置', style: TextStyle(fontSize: 18.0)),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AccessibilityScreen(),
                      ),
                    );
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.volume_up, size: 28),
                  title: const Text('音量设置', style: TextStyle(fontSize: 18.0)),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    // 导航到音量设置
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.language, size: 28),
                  title: const Text('语言设置', style: TextStyle(fontSize: 18.0)),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    // 导航到语言设置
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.color_lens, size: 28),
                  title: const Text('主题设置', style: TextStyle(fontSize: 18.0)),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    // 导航到主题设置
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.notifications, size: 28),
                  title: const Text('通知设置', style: TextStyle(fontSize: 18.0)),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    // 导航到通知设置
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.help, size: 28),
                  title: const Text('帮助与反馈', style: TextStyle(fontSize: 18.0)),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    // 导航到帮助与反馈
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.info, size: 28),
                  title: const Text('关于', style: TextStyle(fontSize: 18.0)),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    // 导航到关于
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
