import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccessibilityScreen extends StatefulWidget {
  const AccessibilityScreen({super.key});

  @override
  State<AccessibilityScreen> createState() => _AccessibilityScreenState();
}

class _AccessibilityScreenState extends State<AccessibilityScreen> {
  bool _reduceAnimations = false;
  bool _enableSound = true;
  bool _enableHaptics = true;
  double _fontSize = 1.0;
  int _colorScheme = 0; // 0: 默认, 1: 高对比度, 2: 暖色调, 3: 冷色调
  int _soundType = 0; // 0: 默认, 1: 柔和, 2: 清晰, 3: 活泼
  double _hapticIntensity = 0.5; // 0.0-1.0
  double _speechRate = 1.0; // 语速: 0.5-2.0
  bool _simplifiedMode = false; // 简化模式
  int _layoutType = 0; // 0: 网格布局, 1: 列表布局
  int _navigationPosition = 0; // 0: 底部, 1: 顶部
  bool _requireConfirmation = false; // 点击确认
  double _longPressDuration = 0.5; // 长按时间
  int _defaultDifficulty = 1; // 默认游戏难度
  int _hintFrequency = 1; // 提示频率: 0: 少, 1: 中, 2: 多
  int _feedbackMode = 0; // 反馈模式: 0: 全部, 1: 仅视觉, 2: 仅听觉
  bool _showVisualCues = true; // 显示视觉提示
  bool _enableNewUserGuide = true; // 启用新手引导

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _reduceAnimations = prefs.getBool('reduceAnimations') ?? false;
      _enableSound = prefs.getBool('enableSound') ?? true;
      _enableHaptics = prefs.getBool('enableHaptics') ?? true;
      _fontSize = prefs.getDouble('fontSize') ?? 1.0;
      _colorScheme = prefs.getInt('colorScheme') ?? 0;
      _soundType = prefs.getInt('soundType') ?? 0;
      _hapticIntensity = prefs.getDouble('hapticIntensity') ?? 0.5;
      _speechRate = prefs.getDouble('speechRate') ?? 1.0;
      _simplifiedMode = prefs.getBool('simplifiedMode') ?? false;
      _layoutType = prefs.getInt('layoutType') ?? 0;
      _navigationPosition = prefs.getInt('navigationPosition') ?? 0;
      _requireConfirmation = prefs.getBool('requireConfirmation') ?? false;
      _longPressDuration = prefs.getDouble('longPressDuration') ?? 0.5;
      _defaultDifficulty = prefs.getInt('defaultDifficulty') ?? 1;
      _hintFrequency = prefs.getInt('hintFrequency') ?? 1;
      _feedbackMode = prefs.getInt('feedbackMode') ?? 0;
      _showVisualCues = prefs.getBool('showVisualCues') ?? true;
      _enableNewUserGuide = prefs.getBool('enableNewUserGuide') ?? true;
    });
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('reduceAnimations', _reduceAnimations);
    await prefs.setBool('enableSound', _enableSound);
    await prefs.setBool('enableHaptics', _enableHaptics);
    await prefs.setDouble('fontSize', _fontSize);
    await prefs.setInt('colorScheme', _colorScheme);
    await prefs.setInt('soundType', _soundType);
    await prefs.setDouble('hapticIntensity', _hapticIntensity);
    await prefs.setDouble('speechRate', _speechRate);
    await prefs.setBool('simplifiedMode', _simplifiedMode);
    await prefs.setInt('layoutType', _layoutType);
    await prefs.setInt('navigationPosition', _navigationPosition);
    await prefs.setBool('requireConfirmation', _requireConfirmation);
    await prefs.setDouble('longPressDuration', _longPressDuration);
    await prefs.setInt('defaultDifficulty', _defaultDifficulty);
    await prefs.setInt('hintFrequency', _hintFrequency);
    await prefs.setInt('feedbackMode', _feedbackMode);
    await prefs.setBool('showVisualCues', _showVisualCues);
    await prefs.setBool('enableNewUserGuide', _enableNewUserGuide);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('个性化设置'),
        backgroundColor: const Color(0xFF4CAF50),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          children: [
            const SizedBox(height: 24),
            const Text(
              '视觉设置',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 16),
            
            // 颜色方案
            Container(
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
                  const Text(
                    '颜色方案',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildColorSchemeOption(0, '默认', const Color(0xFF4CAF50)),
                      _buildColorSchemeOption(1, '高对比度', const Color(0xFFF44336)),
                      _buildColorSchemeOption(2, '暖色调', const Color(0xFFFF9800)),
                      _buildColorSchemeOption(3, '冷色调', const Color(0xFF2196F3)),
                    ],
                  ),
                ],
              ),
            ),
            
            // 字体大小
            Container(
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
                  const Text(
                    '字体大小',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Text('小', style: TextStyle(fontSize: 14.0)),
                      Expanded(
                        child: Slider(
                          value: _fontSize,
                          min: 0.8,
                          max: 1.5,
                          divisions: 7,
                          onChanged: (value) {
                            setState(() {
                              _fontSize = value;
                            });
                          },
                        ),
                      ),
                      const Text('大', style: TextStyle(fontSize: 20.0)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      '示例文本',
                      style: TextStyle(fontSize: 16.0 * _fontSize),
                    ),
                  ),
                ],
              ),
            ),
            
            // 减少动画
            SwitchListTile(
              title: const Text('减少动画效果', style: TextStyle(fontSize: 18.0)),
              value: _reduceAnimations,
              onChanged: (value) {
                setState(() {
                  _reduceAnimations = value;
                });
              },
              activeColor: const Color(0xFF4CAF50),
            ),
            
            const SizedBox(height: 32),
            const Text(
              '感官设置',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 16),
            
            // 声音反馈
            SwitchListTile(
              title: const Text('启用声音反馈', style: TextStyle(fontSize: 18.0)),
              value: _enableSound,
              onChanged: (value) {
                setState(() {
                  _enableSound = value;
                });
              },
              activeColor: const Color(0xFF4CAF50),
            ),
            
            // 触觉反馈
            SwitchListTile(
              title: const Text('启用触觉反馈', style: TextStyle(fontSize: 18.0)),
              value: _enableHaptics,
              onChanged: (value) {
                setState(() {
                  _enableHaptics = value;
                });
              },
              activeColor: const Color(0xFF4CAF50),
            ),
            
            // 触觉反馈强度
            if (_enableHaptics)
              Container(
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
                    const Text(
                      '触觉反馈强度',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF333333),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Text('弱', style: TextStyle(fontSize: 14.0)),
                        Expanded(
                          child: Slider(
                            value: _hapticIntensity,
                            min: 0.0,
                            max: 1.0,
                            divisions: 10,
                            onChanged: (value) {
                              setState(() {
                                _hapticIntensity = value;
                              });
                            },
                          ),
                        ),
                        const Text('强', style: TextStyle(fontSize: 14.0)),
                      ],
                    ),
                  ],
                ),
              ),
            
            // 声音类型
            if (_enableSound)
              Container(
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
                    const Text(
                      '声音类型',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF333333),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildSoundTypeOption(0, '默认'),
                        _buildSoundTypeOption(1, '柔和'),
                        _buildSoundTypeOption(2, '清晰'),
                        _buildSoundTypeOption(3, '活泼'),
                      ],
                    ),
                  ],
                ),
              ),
            
            // 语速调节
            if (_enableSound)
              Container(
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
                    const Text(
                      '语速调节',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF333333),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Text('慢', style: TextStyle(fontSize: 14.0)),
                        Expanded(
                          child: Slider(
                            value: _speechRate,
                            min: 0.5,
                            max: 2.0,
                            divisions: 15,
                            onChanged: (value) {
                              setState(() {
                                _speechRate = value;
                              });
                            },
                          ),
                        ),
                        const Text('快', style: TextStyle(fontSize: 14.0)),
                      ],
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 32),
            const Text(
              '界面设置',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 16),
            
            // 简化模式
            SwitchListTile(
              title: const Text('简化模式', style: TextStyle(fontSize: 18.0)),
              subtitle: const Text('减少界面元素，提供更简洁的操作体验'),
              value: _simplifiedMode,
              onChanged: (value) {
                setState(() {
                  _simplifiedMode = value;
                });
              },
              activeColor: const Color(0xFF4CAF50),
            ),
            
            // 显示视觉提示
            SwitchListTile(
              title: const Text('显示视觉提示', style: TextStyle(fontSize: 18.0)),
              subtitle: const Text('在按钮和重要元素上显示额外的视觉提示'),
              value: _showVisualCues,
              onChanged: (value) {
                setState(() {
                  _showVisualCues = value;
                });
              },
              activeColor: const Color(0xFF4CAF50),
            ),
            
            // 启用新手引导
            SwitchListTile(
              title: const Text('启用新手引导', style: TextStyle(fontSize: 18.0)),
              subtitle: const Text('首次使用时显示详细的操作引导'),
              value: _enableNewUserGuide,
              onChanged: (value) {
                setState(() {
                  _enableNewUserGuide = value;
                });
              },
              activeColor: const Color(0xFF4CAF50),
            ),
            
            // 布局类型
            Container(
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
                  const Text(
                    '布局类型',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildLayoutOption(0, '网格布局', Icons.grid_view),
                      _buildLayoutOption(1, '列表布局', Icons.list),
                    ],
                  ),
                ],
              ),
            ),
            
            // 导航位置
            Container(
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
                  const Text(
                    '导航位置',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildNavigationOption(0, '底部', Icons.south),
                      _buildNavigationOption(1, '顶部', Icons.north),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            const Text(
              '交互设置',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 16),
            
            // 点击确认
            SwitchListTile(
              title: const Text('点击确认', style: TextStyle(fontSize: 18.0)),
              subtitle: const Text('重要操作需要二次确认，防止误操作'),
              value: _requireConfirmation,
              onChanged: (value) {
                setState(() {
                  _requireConfirmation = value;
                });
              },
              activeColor: const Color(0xFF4CAF50),
            ),
            
            // 长按时间
            Container(
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
                  const Text(
                    '长按时间',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Text('短', style: TextStyle(fontSize: 14.0)),
                      Expanded(
                        child: Slider(
                          value: _longPressDuration,
                          min: 0.2,
                          max: 1.0,
                          divisions: 8,
                          onChanged: (value) {
                            setState(() {
                              _longPressDuration = value;
                            });
                          },
                        ),
                      ),
                      const Text('长', style: TextStyle(fontSize: 14.0)),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            const Text(
              '内容设置',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 16),
            
            // 默认游戏难度
            Container(
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
                  const Text(
                    '默认游戏难度',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildDifficultyOption(0, '简单'),
                      _buildDifficultyOption(1, '中等'),
                      _buildDifficultyOption(2, '困难'),
                    ],
                  ),
                ],
              ),
            ),
            
            // 提示频率
            Container(
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
                  const Text(
                    '提示频率',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildHintOption(0, '少'),
                      _buildHintOption(1, '中'),
                      _buildHintOption(2, '多'),
                    ],
                  ),
                ],
              ),
            ),
            
            // 反馈模式
            Container(
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
                  const Text(
                    '反馈模式',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildFeedbackOption(0, '全部'),
                      _buildFeedbackOption(1, '仅视觉'),
                      _buildFeedbackOption(2, '仅听觉'),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // 保存按钮
            ElevatedButton(
              onPressed: () {
                _saveSettings();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('设置已保存'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF50),
                padding: const EdgeInsets.symmetric(vertical: 16.0),
              ),
              child: const Text(
                '保存设置',
                style: TextStyle(fontSize: 18.0, color: Colors.white),
              ),
            ),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildColorSchemeOption(int index, String label, Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _colorScheme = index;
        });
      },
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
              border: Border.all(
                color: _colorScheme == index ? const Color(0xFF333333) : Colors.transparent,
                width: 3.0,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.0,
              color: _colorScheme == index ? const Color(0xFF333333) : const Color(0xFF666666),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSoundTypeOption(int index, String label) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _soundType = index;
        });
      },
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFE3F2FD),
              border: Border.all(
                color: _soundType == index ? const Color(0xFF2196F3) : Colors.transparent,
                width: 3.0,
              ),
            ),
            child: Icon(
              index == 0 ? Icons.volume_up :
              index == 1 ? Icons.volume_down :
              index == 2 ? Icons.volume_mute :
              Icons.volume_off,
              color: const Color(0xFF2196F3),
              size: 32,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.0,
              color: _soundType == index ? const Color(0xFF333333) : const Color(0xFF666666),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLayoutOption(int index, String label, IconData icon) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _layoutType = index;
        });
      },
      child: Column(
        children: [
          Container(
            width: 80,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: _layoutType == index ? const Color(0xFF4CAF50) : const Color(0xFFE0E0E0),
                width: 2.0,
              ),
            ),
            child: Center(
              child: Icon(
                icon,
                color: _layoutType == index ? const Color(0xFF4CAF50) : const Color(0xFF9E9E9E),
                size: 32,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.0,
              color: _layoutType == index ? const Color(0xFF333333) : const Color(0xFF666666),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationOption(int index, String label, IconData icon) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _navigationPosition = index;
        });
      },
      child: Column(
        children: [
          Container(
            width: 80,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: _navigationPosition == index ? const Color(0xFF4CAF50) : const Color(0xFFE0E0E0),
                width: 2.0,
              ),
            ),
            child: Center(
              child: Icon(
                icon,
                color: _navigationPosition == index ? const Color(0xFF4CAF50) : const Color(0xFF9E9E9E),
                size: 32,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.0,
              color: _navigationPosition == index ? const Color(0xFF333333) : const Color(0xFF666666),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDifficultyOption(int index, String label) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _defaultDifficulty = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: _defaultDifficulty == index ? const Color(0xFFE8F5E8) : Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: _defaultDifficulty == index ? const Color(0xFF4CAF50) : const Color(0xFFE0E0E0),
            width: 2.0,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14.0,
            color: _defaultDifficulty == index ? const Color(0xFF333333) : const Color(0xFF666666),
          ),
        ),
      ),
    );
  }

  Widget _buildHintOption(int index, String label) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _hintFrequency = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: _hintFrequency == index ? const Color(0xFFE8F5E8) : Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: _hintFrequency == index ? const Color(0xFF4CAF50) : const Color(0xFFE0E0E0),
            width: 2.0,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14.0,
            color: _hintFrequency == index ? const Color(0xFF333333) : const Color(0xFF666666),
          ),
        ),
      ),
    );
  }

  Widget _buildFeedbackOption(int index, String label) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _feedbackMode = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: _feedbackMode == index ? const Color(0xFFE8F5E8) : Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: _feedbackMode == index ? const Color(0xFF4CAF50) : const Color(0xFFE0E0E0),
            width: 2.0,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14.0,
            color: _feedbackMode == index ? const Color(0xFF333333) : const Color(0xFF666666),
          ),
        ),
      ),
    );
  }
}
