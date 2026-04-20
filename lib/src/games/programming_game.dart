import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:autism_work_integration_tool/src/models/game_level.dart';
import 'package:autism_work_integration_tool/src/providers/game_provider.dart';

class ProgrammingGame extends StatefulWidget {
  const ProgrammingGame({super.key});

  @override
  State<ProgrammingGame> createState() => _ProgrammingGameState();
}

class _ProgrammingGameState extends State<ProgrammingGame> {
  late GameLevel _currentLevel;
  int _currentDifficulty = 1;
  String _task = '';
  List<String> _availableBlocks = [];
  List<String> _userBlocks = [];
  bool _isGameComplete = false;
  bool _isCorrect = false;
  String _correctAnswer = '';
  bool _showHint = false;

  final List<List<Map<String, dynamic>>> _programmingTasks = [
    // 难度级别 1：职场入门
    [
      {
        'task': '打印工作日问候',
        'blocks': ['print("Good morning, team!")', 'def main():', 'main()'],
        'correctOrder': 'def main():\n    print("Good morning, team!")\nmain()',
        'hint': '先定义主函数，然后在函数内打印问候语，最后调用主函数',
      },
      {
        'task': '打印会议提醒',
        'blocks': ['print("Meeting at 2 PM")', 'def main():', 'main()'],
        'correctOrder': 'def main():\n    print("Meeting at 2 PM")\nmain()',
        'hint': '先定义主函数，然后在函数内打印会议提醒，最后调用主函数',
      },
      {
        'task': '打印工作待办',
        'blocks': ['print("Today\'s tasks: 1. Email 2. Report")', 'def main():', 'main()'],
        'correctOrder': 'def main():\n    print("Today\'s tasks: 1. Email 2. Report")\nmain()',
        'hint': '先定义主函数，然后在函数内打印待办事项，最后调用主函数',
      },
      {
        'task': '打印工作地点',
        'blocks': ['print("Working from office")', 'def main():', 'main()'],
        'correctOrder': 'def main():\n    print("Working from office")\nmain()',
        'hint': '先定义主函数，然后在函数内打印工作地点，最后调用主函数',
      },
      {
        'task': '打印工作时间',
        'blocks': ['print("Work hours: 9 AM - 5 PM")', 'def main():', 'main()'],
        'correctOrder': 'def main():\n    print("Work hours: 9 AM - 5 PM")\nmain()',
        'hint': '先定义主函数，然后在函数内打印工作时间，最后调用主函数',
      },
    ],
    // 难度级别 2：职场基础
    [
      {
        'task': '计算工作时长',
        'blocks': ['print(end - start)', 'start = 9', 'end = 17', 'def main():', 'main()'],
        'correctOrder': 'def main():\n    start = 9\n    end = 17\n    print(end - start)\nmain()',
        'hint': '先定义主函数，然后设置开始和结束时间，计算并打印工作时长，最后调用主函数',
      },
      {
        'task': '计算加班工资',
        'blocks': ['print(overtime * rate * 1.5)', 'overtime = 2', 'rate = 20', 'def main():', 'main()'],
        'correctOrder': 'def main():\n    overtime = 2\n    rate = 20\n    print(overtime * rate * 1.5)\nmain()',
        'hint': '先定义主函数，然后设置加班时间和时薪，计算并打印加班工资，最后调用主函数',
      },
      {
        'task': '计算项目进度',
        'blocks': ['print(completed / total * 100)', 'completed = 3', 'total = 5', 'def main():', 'main()'],
        'correctOrder': 'def main():\n    completed = 3\n    total = 5\n    print(completed / total * 100)\nmain()',
        'hint': '先定义主函数，然后设置已完成和总任务数，计算并打印项目进度百分比，最后调用主函数',
      },
      {
        'task': '计算每日任务完成数',
        'blocks': ['print(done)', 'done = 5', 'total = 8', 'def main():', 'main()'],
        'correctOrder': 'def main():\n    total = 8\n    done = 5\n    print(done)\nmain()',
        'hint': '先定义主函数，然后设置总任务数和已完成任务数，打印已完成任务数，最后调用主函数',
      },
      {
        'task': '计算会议时长',
        'blocks': ['print(end - start)', 'start = 14', 'end = 15', 'def main():', 'main()'],
        'correctOrder': 'def main():\n    start = 14\n    end = 15\n    print(end - start)\nmain()',
        'hint': '先定义主函数，然后设置会议开始和结束时间，计算并打印会议时长，最后调用主函数',
      },
    ],
    // 难度级别 3：职场进阶
    [
      {
        'task': '生成工作日历',
        'blocks': ['for day in days:', 'print(day)', 'days = ["Mon", "Tue", "Wed", "Thu", "Fri"]', 'def main():', 'main()'],
        'correctOrder': 'def main():\n    days = ["Mon", "Tue", "Wed", "Thu", "Fri"]\n    for day in days:\n        print(day)\nmain()',
        'hint': '先定义主函数，然后创建工作日列表，使用循环打印每一天，最后调用主函数',
      },
      {
        'task': '统计工作任务',
        'blocks': ['for task in tasks:', 'print(f"Task: {task}")', 'tasks = ["Email", "Meeting", "Report"]', 'def main():', 'main()'],
        'correctOrder': 'def main():\n    tasks = ["Email", "Meeting", "Report"]\n    for task in tasks:\n        print(f"Task: {task}")\nmain()',
        'hint': '先定义主函数，然后创建任务列表，使用循环打印每个任务，最后调用主函数',
      },
      {
        'task': '计算每周工作小时',
        'blocks': ['for hours in daily_hours:', 'total += hours', 'total = 0', 'daily_hours = [8, 8, 8, 8, 8]', 'print(total)', 'def main():', 'main()'],
        'correctOrder': 'def main():\n    daily_hours = [8, 8, 8, 8, 8]\n    total = 0\n    for hours in daily_hours:\n        total += hours\n    print(total)\nmain()',
        'hint': '先定义主函数，然后创建每日工作小时列表，初始化总小时数为0，使用循环累加，最后打印总小时数并调用主函数',
      },
      {
        'task': '处理客户名单',
        'blocks': ['for client in clients:', 'print(f"Client: {client}")', 'clients = ["Alice", "Bob", "Charlie"]', 'def main():', 'main()'],
        'correctOrder': 'def main():\n    clients = ["Alice", "Bob", "Charlie"]\n    for client in clients:\n        print(f"Client: {client}")\nmain()',
        'hint': '先定义主函数，然后创建客户列表，使用循环打印每个客户，最后调用主函数',
      },
      {
        'task': '处理部门列表',
        'blocks': ['for dept in departments:', 'print(f"Department: {dept}")', 'departments = ["HR", "IT", "Finance"]', 'def main():', 'main()'],
        'correctOrder': 'def main():\n    departments = ["HR", "IT", "Finance"]\n    for dept in departments:\n        print(f"Department: {dept}")\nmain()',
        'hint': '先定义主函数，然后创建部门列表，使用循环打印每个部门，最后调用主函数',
      },
    ],
    // 难度级别 4：职场熟练
    [
      {
        'task': '判断工作优先级',
        'blocks': ['if priority == "high":', 'print("Do first")', 'else:', 'print("Do later")', 'priority = "high"', 'def main():', 'main()'],
        'correctOrder': 'def main():\n    priority = "high"\n    if priority == "high":\n        print("Do first")\n    else:\n        print("Do later")\nmain()',
        'hint': '先定义主函数，然后设置优先级，使用if-else判断优先级并打印对应信息，最后调用主函数',
      },
      {
        'task': '判断会议时间',
        'blocks': ['if hour < 12:', 'print("Morning meeting")', 'elif hour < 18:', 'print("Afternoon meeting")', 'else:', 'print("Evening meeting")', 'hour = 14', 'def main():', 'main()'],
        'correctOrder': 'def main():\n    hour = 14\n    if hour < 12:\n        print("Morning meeting")\n    elif hour < 18:\n        print("Afternoon meeting")\n    else:\n        print("Evening meeting")\nmain()',
        'hint': '先定义主函数，然后设置会议时间，使用if-elif-else判断时间并打印对应信息，最后调用主函数',
      },
      {
        'task': '判断项目状态',
        'blocks': ['if progress >= 100:', 'print("Completed")', 'elif progress >= 50:', 'print("In progress")', 'else:', 'print("Just started")', 'progress = 75', 'def main():', 'main()'],
        'correctOrder': 'def main():\n    progress = 75\n    if progress >= 100:\n        print("Completed")\n    elif progress >= 50:\n        print("In progress")\n    else:\n        print("Just started")\nmain()',
        'hint': '先定义主函数，然后设置项目进度，使用if-elif-else判断进度并打印对应状态，最后调用主函数',
      },
      {
        'task': '判断工作模式',
        'blocks': ['if mode == "remote":', 'print("Work from home")', 'elif mode == "hybrid":', 'print("Work from office and home")', 'else:', 'print("Work from office")', 'mode = "hybrid"', 'def main():', 'main()'],
        'correctOrder': 'def main():\n    mode = "hybrid"\n    if mode == "remote":\n        print("Work from home")\n    elif mode == "hybrid":\n        print("Work from office and home")\n    else:\n        print("Work from office")\nmain()',
        'hint': '先定义主函数，然后设置工作模式，使用if-elif-else判断工作模式并打印对应信息，最后调用主函数',
      },
      {
        'task': '判断任务类型',
        'blocks': ['if task_type == "urgent":', 'print("Priority task")', 'elif task_type == "important":', 'print("High priority")', 'else:', 'print("Normal task")', 'task_type = "urgent"', 'def main():', 'main()'],
        'correctOrder': 'def main():\n    task_type = "urgent"\n    if task_type == "urgent":\n        print("Priority task")\n    elif task_type == "important":\n        print("High priority")\n    else:\n        print("Normal task")\nmain()',
        'hint': '先定义主函数，然后设置任务类型，使用if-elif-else判断任务类型并打印对应信息，最后调用主函数',
      },
    ],
    // 难度级别 5：职场独立
    [
      {
        'task': '自动化邮件发送',
        'blocks': ['def send_email(to, subject):', 'print(f"Email sent to {to} with subject: {subject}")', 'send_email("team@company.com", "Meeting Reminder")', 'def main():', 'main()'],
        'correctOrder': 'def send_email(to, subject):\n    print(f"Email sent to {to} with subject: {subject}")\n\ndef main():\n    send_email("team@company.com", "Meeting Reminder")\nmain()',
        'hint': '先定义发送邮件的函数，然后定义主函数，在主函数中调用发送邮件函数，最后调用主函数',
      },
      {
        'task': '计算月度绩效',
        'blocks': ['def calculate_performance(tasks, deadlines):', 'return len(tasks) / len(deadlines) * 100', 'tasks = 8', 'deadlines = 10', 'print(calculate_performance(tasks, deadlines))', 'def main():', 'main()'],
        'correctOrder': 'def calculate_performance(tasks, deadlines):\n    return len(tasks) / len(deadlines) * 100\n\ndef main():\n    tasks = 8\n    deadlines = 10\n    print(calculate_performance(tasks, deadlines))\nmain()',
        'hint': '先定义计算绩效的函数，然后定义主函数，在主函数中设置任务和截止日期，调用绩效函数并打印结果，最后调用主函数',
      },
      {
        'task': '综合办公自动化',
        'blocks': ['def process_data(data):', 'for item in data:', 'print(f"Processing: {item}")', 'data = ["Email", "Report", "Meeting"]', 'process_data(data)', 'def main():', 'main()'],
        'correctOrder': 'def process_data(data):\n    for item in data:\n        print(f"Processing: {item}")\n\ndef main():\n    data = ["Email", "Report", "Meeting"]\n    process_data(data)\nmain()',
        'hint': '先定义处理数据的函数，使用循环处理每个数据项，然后定义主函数，创建数据列表并调用处理函数，最后调用主函数',
      },
      {
        'task': '员工信息管理',
        'blocks': ['def get_employee_info(name):', 'return f"Employee: {name}"', 'print(get_employee_info("Alice"))', 'def main():', 'main()'],
        'correctOrder': 'def get_employee_info(name):\n    return f"Employee: {name}"\n\ndef main():\n    print(get_employee_info("Alice"))\nmain()',
        'hint': '先定义获取员工信息的函数，然后定义主函数，调用员工信息函数并打印结果，最后调用主函数',
      },
      {
        'task': '项目进度跟踪',
        'blocks': ['def track_progress(tasks, completed):', 'return f"Progress: {completed/len(tasks)*100}%"', 'tasks = ["Task1", "Task2", "Task3"]', 'completed = 2', 'print(track_progress(tasks, completed))', 'def main():', 'main()'],
        'correctOrder': 'def track_progress(tasks, completed):\n    return f"Progress: {completed/len(tasks)*100}%"\n\ndef main():\n    tasks = ["Task1", "Task2", "Task3"]\n    completed = 2\n    print(track_progress(tasks, completed))\nmain()',
        'hint': '先定义跟踪项目进度的函数，然后定义主函数，设置任务列表和已完成任务数，调用进度函数并打印结果，最后调用主函数',
      },
    ],
  ];
  
  int _currentTaskIndex = 0;

  final List<GameLevel> _levels = [
    GameLevel(
      id: 1,
      difficulty: 1,
      title: '职场入门',
      description: '简单的Python基础语法',
      items: [],
    ),
    GameLevel(
      id: 2,
      difficulty: 2,
      title: '职场基础',
      description: '基本的变量和运算',
      items: [],
    ),
    GameLevel(
      id: 3,
      difficulty: 3,
      title: '职场进阶',
      description: '循环和条件判断',
      items: [],
    ),
    GameLevel(
      id: 4,
      difficulty: 4,
      title: '职场熟练',
      description: '函数定义和调用',
      items: [],
    ),
    GameLevel(
      id: 5,
      difficulty: 5,
      title: '职场独立',
      description: '综合编程应用',
      items: [],
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
    _generateTask();
    _userBlocks = [];
    _isGameComplete = false;
    _isCorrect = false;
  }

  void _generateTask() {
    try {
      final difficultyIndex = _currentDifficulty - 1;
      if (difficultyIndex < 0 || difficultyIndex >= _programmingTasks.length) {
        // 边界情况：难度级别超出范围
        _currentDifficulty = 1;
        _generateTask();
        return;
      }
      
      final tasks = _programmingTasks[difficultyIndex];
      if (tasks.isEmpty) {
        // 边界情况：任务列表为空
        _task = '任务加载失败，请重试';
        _availableBlocks = [];
        _correctAnswer = '';
        _showHint = false;
        return;
      }
      
      final task = tasks[_currentTaskIndex % tasks.length];
      _task = task['task'] ?? '任务加载失败';
      _availableBlocks = List.from(task['blocks'] ?? [])..shuffle();
      _correctAnswer = task['correctOrder'] ?? '';
      _showHint = false;
    } catch (e) {
      // 边界情况：任何异常
      _task = '任务加载失败，请重试';
      _availableBlocks = [];
      _correctAnswer = '';
      _showHint = false;
    }
  }

  String _getHint() {
    try {
      final difficultyIndex = _currentDifficulty - 1;
      if (difficultyIndex < 0 || difficultyIndex >= _programmingTasks.length) {
        return '请选择合适的难度级别';
      }
      
      final tasks = _programmingTasks[difficultyIndex];
      if (tasks.isEmpty) {
        return '暂无提示信息';
      }
      
      final task = tasks[_currentTaskIndex % tasks.length];
      return task['hint'] ?? '暂无提示信息';
    } catch (e) {
      return '暂无提示信息';
    }
  }

  void _selectBlock(String block) {
    if (!_isGameComplete && _availableBlocks.contains(block)) {
      setState(() {
        _userBlocks.add(block);
        _availableBlocks.remove(block);
      });
    }
  }

  void _removeBlock(String block) {
    if (!_isGameComplete && _userBlocks.contains(block)) {
      setState(() {
        _userBlocks.remove(block);
        _availableBlocks.add(block);
      });
    }
  }

  void _checkAnswer() {
    // 构建用户答案，添加适当的缩进
    String userAnswer = '';
    for (int i = 0; i < _userBlocks.length; i++) {
      if (_userBlocks[i].startsWith('def ') || _userBlocks[i].startsWith('else:')) {
        userAnswer += _userBlocks[i] + '\n';
      } else {
        userAnswer += '    ' + _userBlocks[i] + '\n';
      }
    }
    _isCorrect = userAnswer.trim() == _correctAnswer.trim();
    _isGameComplete = true;
    
    if (_isCorrect) {
      // 计算积分：根据难度级别计算积分
      int score = _currentDifficulty * 100;
      
      // 保存游戏进度和积分
      final gameProvider = Provider.of<GameProvider>(context, listen: false);
      gameProvider.updateGameScore('编程游戏', score);
      gameProvider.updateGameLevel('编程游戏', _currentDifficulty);
    }
  }

  void _nextTask() {
    _currentTaskIndex++;
    _loadLevel(_currentDifficulty);
  }

  String _getPositiveFeedback() {
    final feedbacks = [
      '你做得很棒！继续加油！',
      '太棒了！你是编程小能手！',
      '非常好！你掌握了这个编程技巧！',
      '优秀！你正在进步！',
      '完美！你解决了这个问题！',
      '厉害！你理解了编程逻辑！',
      '超棒！你是职场编程达人！',
      '好样的！你离成功更近了！',
    ];
    return feedbacks[DateTime.now().millisecond % feedbacks.length];
  }

  String _getEncouragingFeedback() {
    final feedbacks = [
      '没关系，再试一次吧！你可以做到的！',
      '不要气馁，编程需要练习！',
      '再仔细看看代码，你会发现问题的！',
      '编程就是不断尝试的过程，继续努力！',
      '你已经很接近了，再试一次！',
      '错误是学习的机会，加油！',
      '慢慢来，你会掌握的！',
      '相信自己，你有这个能力！',
    ];
    return feedbacks[DateTime.now().millisecond % feedbacks.length];
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('简单编程游戏'),
        backgroundColor: const Color(0xFFF44336),
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
            const SizedBox(height: 32),

            // 任务描述
            Container(
              padding: const EdgeInsets.all(24.0),
              margin: const EdgeInsets.symmetric(vertical: 16.0),
              decoration: BoxDecoration(
                color: const Color(0xFFFFEBEE),
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                  color: const Color(0xFFF44336),
                  width: 2.0,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    '任务: $_task',
                    style: const TextStyle(
                      fontSize: 20.0,
                      color: Color(0xFF333333),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _showHint = !_showHint;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF44336),
                    ),
                    child: Text(_showHint ? '隐藏提示' : '显示提示'),
                  ),
                  if (_showHint)
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          _getHint(),
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Color(0xFF333333),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            
            // 进度指示器
            Container(
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.symmetric(vertical: 16.0),
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
                    '学习进度',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 12),
                  LinearProgressIndicator(
                    value: (_currentTaskIndex % 5 + 1) / 5,
                    backgroundColor: const Color(0xFFF5F5F5),
                    valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF4CAF50)),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '第 ${_currentTaskIndex % 5 + 1} 题 / 共 5 题',
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Color(0xFF666666),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // 可用代码块
            Text(
              '可用代码块:',
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12.0,
              runSpacing: 12.0,
              children: _availableBlocks.map((block) {
                return GestureDetector(
                  onTap: () => _selectBlock(block),
                  child: Chip(
                    label: Text(
                      block,
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Color(0xFF333333),
                      ),
                    ),
                    backgroundColor: const Color(0xFFFFCDD2),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 8.0,
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 32),

            // 用户代码
            Text(
              '您的代码:',
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.symmetric(vertical: 16.0),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: const Color(0xFFE0E0E0),
                  width: 2.0,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _userBlocks.asMap().entries.map((entry) {
                  int index = entry.key;
                  String block = entry.value;
                  return GestureDetector(
                    onTap: () => _removeBlock(block),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 8.0,
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 4.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFCDD2),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        children: [
                          Text(
                            index.toString().padLeft(2, '0') + ': ',
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Color(0xFF666666),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              block,
                              style: const TextStyle(
                                fontSize: 16.0,
                                color: Color(0xFF333333),
                              ),
                            ),
                          ),
                          Icon(
                            Icons.remove_circle,
                            color: const Color(0xFFF44336),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 32),

            // 提交按钮
            ElevatedButton(
              onPressed: _checkAnswer,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF50),
              ),
              child: const Text('提交代码'),
            ),

            const SizedBox(height: 32),

            // 游戏结果
            if (_isGameComplete)
              Container(
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.symmetric(vertical: 16.0),
                decoration: BoxDecoration(
                  color: _isCorrect ? const Color(0xFFE8F5E9) : const Color(0xFFFFEBEE),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    Text(
                      _isCorrect ? '代码正确！' : '代码错误',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: _isCorrect ? const Color(0xFF2E7D32) : const Color(0xFFC62828),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    if (!_isCorrect)
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Text(
                          '正确答案:\n$_correctAnswer',
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Color(0xFF666666),
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    const SizedBox(height: 8),
                    Text(
                      _isCorrect 
                          ? _getPositiveFeedback() 
                          : _getEncouragingFeedback(),
                      style: TextStyle(
                        fontSize: 16.0,
                        color: _isCorrect ? const Color(0xFF2E7D32) : const Color(0xFFC62828),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    if (_isCorrect)
                      ElevatedButton(
                        onPressed: _nextTask,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4CAF50),
                        ),
                        child: const Text('下一题'),
                      ),
                  ],
                ),
              ),

            const SizedBox(height: 32),

            // 控制按钮
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _prevLevel,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEF9A9A),
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
