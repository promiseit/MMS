import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:autism_work_integration_tool/src/models/game_level.dart';
import 'package:autism_work_integration_tool/src/providers/game_provider.dart';

class MixedModeGame extends StatefulWidget {
  const MixedModeGame({super.key});

  @override
  State<MixedModeGame> createState() => _MixedModeGameState();
}

class _MixedModeGameState extends State<MixedModeGame> {
  late GameLevel _currentLevel;
  int _currentDifficulty = 1;
  int _currentTaskIndex = 0;
  String _userAnswer = '';
  bool _isTaskComplete = false;
  bool _isCorrect = false;
  int _correctTasks = 0;
  int _totalTasks = 0;

  final List<GameLevel> _levels = [
    GameLevel(
      id: 1,
      difficulty: 1,
      title: '职场综合入门',
      description: '简单的职场综合任务',
      items: [
        '排序：打卡上班,整理桌面,查看邮件,开始工作',
        '计算：10+5=?',
        '拼写：hello',
      ],
    ),
    GameLevel(
      id: 2,
      difficulty: 2,
      title: '职场综合基础',
      description: '基本的职场综合任务',
      items: [
        '排序：接收任务,制定计划,执行任务,检查成果,提交报告',
        '计算：25-8=?',
        '拼写：office',
        '编程：print("Hello")',
      ],
    ),
    GameLevel(
      id: 3,
      difficulty: 3,
      title: '职场综合进阶',
      description: '复杂的职场综合任务',
      items: [
        '排序：客户需求分析,方案设计,方案实施,质量检查,客户验收,项目总结',
        '计算：15*4=?',
        '拼写：meeting',
        '编程：for i in range(3): print(i)',
        '排序：优先级排序,时间分配,并行处理,进度跟踪,资源协调,结果评估',
      ],
    ),
    GameLevel(
      id: 4,
      difficulty: 4,
      title: '职场综合熟练',
      description: '多任务职场综合任务',
      items: [
        '计算：(20+15)*2=?',
        '拼写：presentation',
        '编程：def add(a, b): return a + b',
        '排序：项目启动,需求调研,计划制定,团队分工,执行实施,风险管理,质量控制,项目验收,经验总结',
        '计算：100/4-5=?',
        '拼写：professional',
      ],
    ),
    GameLevel(
      id: 5,
      difficulty: 5,
      title: '职场综合专家',
      description: '复杂项目的综合任务',
      items: [
        '编程：list comprehension [x*2 for x in range(5)]',
        '计算：(50-10)*3/4=?',
        '排序：市场调研,产品设计,原型开发,用户测试,迭代优化,产品发布,市场推广,用户反馈,持续改进',
        '拼写：communication',
        '计算：120*0.8+50=?',
        '编程：try-except block',
        '排序：团队建设,目标设定,绩效考核,反馈沟通,技能培训,职业发展,团队文化建设',
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _loadLevel(_currentDifficulty);
  }

  void _loadLevel(int difficulty) {
    _currentLevel = _levels.firstWhere((level) => level.difficulty == difficulty);
    _currentTaskIndex = 0;
    _userAnswer = '';
    _isTaskComplete = false;
    _isCorrect = false;
    _correctTasks = 0;
    _totalTasks = _currentLevel.items.length;
  }

  String _getTaskType(String task) {
    if (task.startsWith('排序：')) {
      return '排序';
    } else if (task.startsWith('计算：')) {
      return '计算';
    } else if (task.startsWith('拼写：')) {
      return '拼写';
    } else if (task.startsWith('编程：')) {
      return '编程';
    }
    return '任务';
  }

  String _getTaskContent(String task) {
    if (task.startsWith('排序：')) {
      return task.substring(3);
    } else if (task.startsWith('计算：')) {
      return task.substring(3);
    } else if (task.startsWith('拼写：')) {
      return task.substring(3);
    } else if (task.startsWith('编程：')) {
      return task.substring(3);
    }
    return task;
  }

  bool _checkAnswer(String task, String userAnswer) {
    if (task.startsWith('排序：')) {
      String correctOrder = task.substring(3);
      return userAnswer == correctOrder;
    } else if (task.startsWith('计算：')) {
      String expression = task.substring(3).replaceAll('=?', '');
      int correctAnswer = _evaluateExpression(expression);
      return userAnswer == correctAnswer.toString();
    } else if (task.startsWith('拼写：')) {
      String correctSpelling = task.substring(3);
      return userAnswer.toLowerCase() == correctSpelling.toLowerCase();
    } else if (task.startsWith('编程：')) {
      String correctCode = task.substring(3);
      return userAnswer.trim() == correctCode.trim();
    }
    return false;
  }

  int _evaluateExpression(String expression) {
    try {
      // 简单的表达式计算
      List<String> parts = expression.split('+');
      if (parts.length > 1) {
        return int.parse(parts[0].trim()) + int.parse(parts[1].trim());
      }
      parts = expression.split('-');
      if (parts.length > 1) {
        return int.parse(parts[0].trim()) - int.parse(parts[1].trim());
      }
      parts = expression.split('*');
      if (parts.length > 1) {
        return int.parse(parts[0].trim()) * int.parse(parts[1].trim());
      }
      parts = expression.split('/');
      if (parts.length > 1) {
        return int.parse(parts[0].trim()) ~/ int.parse(parts[1].trim());
      }
    } catch (e) {
      return 0;
    }
    return 0;
  }

  void _submitAnswer() {
    if (!_isTaskComplete) {
      setState(() {
        _isTaskComplete = true;
        _isCorrect = _checkAnswer(_currentLevel.items[_currentTaskIndex], _userAnswer);
        if (_isCorrect) {
          _correctTasks++;
          
          // 计算积分：根据难度级别计算积分
          int score = _currentDifficulty * 100;
          
          // 保存游戏进度和积分
          final gameProvider = Provider.of<GameProvider>(context, listen: false);
          gameProvider.updateGameScore('混合模式游戏', score);
          gameProvider.updateGameLevel('混合模式游戏', _currentDifficulty);
        }
      });
    }
  }

  void _nextTask() {
    if (_currentTaskIndex < _currentLevel.items.length - 1) {
      setState(() {
        _currentTaskIndex++;
        _userAnswer = '';
        _isTaskComplete = false;
        _isCorrect = false;
      });
    }
  }

  void _prevTask() {
    if (_currentTaskIndex > 0) {
      setState(() {
        _currentTaskIndex--;
        _userAnswer = '';
        _isTaskComplete = false;
        _isCorrect = false;
      });
    }
  }

  void _nextLevel() {
    if (_currentDifficulty < 5) {
      setState(() {
        _currentDifficulty++;
        _loadLevel(_currentDifficulty);
      });
    }
  }

  void _prevLevel() {
    if (_currentDifficulty > 1) {
      setState(() {
        _currentDifficulty--;
        _loadLevel(_currentDifficulty);
      });
    }
  }

  void _restartLevel() {
    _loadLevel(_currentDifficulty);
  }

  @override
  Widget build(BuildContext context) {
    String currentTask = _currentLevel.items[_currentTaskIndex];
    String taskType = _getTaskType(currentTask);
    String taskContent = _getTaskContent(currentTask);

    return Scaffold(
      appBar: AppBar(
        title: const Text('混合模式游戏'),
        backgroundColor: const Color(0xFF9C27B0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Text(
              _currentLevel.title,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _currentLevel.description,
              style: const TextStyle(
                fontSize: 16.0,
                color: Color(0xFF666666),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              '任务 ${_currentTaskIndex + 1}/${_totalTasks}',
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
            Text(
              '得分: $_correctTasks/$_totalTasks',
              style: const TextStyle(
                fontSize: 16.0,
                color: Color(0xFF666666),
              ),
            ),
            const SizedBox(height: 32),

            // 任务类型和内容
            Container(
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.symmetric(vertical: 16.0),
              decoration: BoxDecoration(
                color: const Color(0xFFF3E5F5),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                children: [
                  Text(
                    taskType,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF7B1FA2),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    taskContent,
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

            // 用户输入
            TextField(
              onChanged: (value) {
                if (!_isTaskComplete) {
                  setState(() {
                    _userAnswer = value;
                  });
                }
              },
              enabled: !_isTaskComplete,
              decoration: InputDecoration(
                labelText: '请输入答案',
                labelStyle: const TextStyle(
                  fontSize: 16.0,
                  color: Color(0xFF666666),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              style: const TextStyle(
                fontSize: 18.0,
                color: Color(0xFF333333),
              ),
            ),

            const SizedBox(height: 32),

            // 游戏结果
            if (_isTaskComplete)
              Container(
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.symmetric(vertical: 16.0),
                decoration: BoxDecoration(
                  color: _isCorrect ? const Color(0xFFE8F5E9) : const Color(0xFFFFEBEE),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Text(
                  _isCorrect ? '回答正确！' : '回答错误，请重试',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: _isCorrect ? const Color(0xFF2E7D32) : const Color(0xFFC62828),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

            const SizedBox(height: 32),

            // 任务控制按钮
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _prevTask,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFCE93D8),
                  ),
                  child: const Text('上一题'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _submitAnswer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF9C27B0),
                  ),
                  child: const Text('提交答案'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _nextTask,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFCE93D8),
                  ),
                  child: const Text('下一题'),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // 级别控制按钮
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _prevLevel,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF90CAF9),
                  ),
                  child: const Text('上一级'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _restartLevel,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFC107),
                  ),
                  child: const Text('重新开始'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _nextLevel,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF50),
                  ),
                  child: const Text('下一级'),
                ),
              ],
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
