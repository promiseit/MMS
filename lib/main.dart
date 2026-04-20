import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:autism_work_integration_tool/src/ui/home_screen.dart';
import 'package:autism_work_integration_tool/src/ui/new_user_guide_screen.dart';
import 'package:autism_work_integration_tool/src/ui/theme.dart';
import 'package:autism_work_integration_tool/src/providers/game_provider.dart';
import 'package:autism_work_integration_tool/src/services/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  // 初始化服务定位器
  await serviceLocator.init();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GameProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '自闭症工作融入支持工具',
      theme: appTheme,
      home: const InitialScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/guide': (context) => const NewUserGuideScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  void initState() {
    super.initState();
    _checkIfFirstTime();
  }

  void _checkIfFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    final hasCompletedGuide = prefs.getBool('hasCompletedGuide') ?? false;
    final enableNewUserGuide = prefs.getBool('enableNewUserGuide') ?? true;

    if (!hasCompletedGuide && enableNewUserGuide) {
      // 首次使用且启用了新手引导，显示引导屏幕
      Navigator.pushReplacementNamed(context, '/guide');
    } else {
      // 非首次使用或禁用了新手引导，直接进入主屏幕
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    // 显示一个简单的加载屏幕
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text('加载中...'),
          ],
        ),
      ),
    );
  }
}

