import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewUserGuideScreen extends StatefulWidget {
  const NewUserGuideScreen({super.key});

  @override
  State<NewUserGuideScreen> createState() => _NewUserGuideScreenState();
}

class _NewUserGuideScreenState extends State<NewUserGuideScreen> {
  int _currentStep = 0;
  final PageController _pageController = PageController();

  final List<Map<String, dynamic>> _guideSteps = [
    {
      'title': '欢迎使用职场融合支持工具',
      'description': '这是一款专为自闭症用户设计的职场技能训练工具，帮助你更好地准备和适应职场环境。',
      'image': Icons.home,
      'color': const Color(0xFF4CAF50),
    },
    {
      'title': '个性化设置',
      'description': '你可以根据自己的需求调整视觉、听觉和操作设置，让工具更适合你。',
      'image': Icons.settings,
      'color': const Color(0xFF2196F3),
    },
    {
      'title': '游戏训练',
      'description': '通过有趣的游戏练习职场必备技能，包括文字排序、数字计算、英语拼写和编程基础。',
      'image': Icons.games,
      'color': const Color(0xFFFF9800),
    },
    {
      'title': '社交技能练习',
      'description': '通过模拟场景练习职场社交技能，如问候、会议参与、团队合作等。',
      'image': Icons.people,
      'color': const Color(0xFF9C27B0),
    },
    {
      'title': '开始你的职场之旅',
      'description': '点击开始按钮，开始你的职场技能训练之旅！',
      'image': Icons.play_circle_filled,
      'color': const Color(0xFFF44336),
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < _guideSteps.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentStep++;
      });
    } else {
      _completeGuide();
    }
  }

  void _prevStep() {
    if (_currentStep > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentStep--;
      });
    }
  }

  void _completeGuide() async {
    // 标记新手引导已完成
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasCompletedGuide', true);
    
    // 导航到主屏幕
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _guideSteps.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentStep = index;
                  });
                },
                itemBuilder: (context, index) {
                  final step = _guideSteps[index];
                  return Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            color: step['color'].withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            step['image'],
                            size: 80,
                            color: step['color'],
                          ),
                        ),
                        const SizedBox(height: 40),
                        Text(
                          step['title'],
                          style: const TextStyle(
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF333333),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        Text(
                          step['description'],
                          style: const TextStyle(
                            fontSize: 18.0,
                            color: Color(0xFF666666),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _guideSteps.length,
                      (index) => Container(
                        width: 10,
                        height: 10,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: index == _currentStep
                              ? const Color(0xFF4CAF50)
                              : const Color(0xFFE0E0E0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (_currentStep > 0)
                        ElevatedButton(
                          onPressed: _prevStep,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF9E9E9E),
                          ),
                          child: const Text('上一步'),
                        ),
                      if (_currentStep > 0) const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _nextStep,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4CAF50),
                          ),
                          child: Text(
                            _currentStep == _guideSteps.length - 1
                                ? '开始使用'
                                : '下一步',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
