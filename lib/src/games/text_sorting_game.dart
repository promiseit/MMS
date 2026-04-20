import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:autism_work_integration_tool/src/models/game_level.dart';
import 'package:autism_work_integration_tool/src/providers/game_provider.dart';

class TextSortingGame extends StatefulWidget {
  const TextSortingGame({super.key});

  @override
  State<TextSortingGame> createState() => _TextSortingGameState();
}

class _TextSortingGameState extends State<TextSortingGame> {
  late GameLevel _currentLevel;
  int _currentDifficulty = 1;
  List<String> _shuffledItems = [];
  List<String> _userOrder = [];
  bool _isGameComplete = false;
  bool _isCorrect = false;
  bool _showHint = false;
  int _currentTaskIndex = 0;

  final List<GameLevel> _levels = [
    GameLevel(
      id: 1,
      difficulty: 1,
      title: '职场入门',
      description: '简单的职场指令排序',
      items: [
        '打卡上班',
        '整理桌面',
        '查看邮件',
        '开始工作',
      ],
    ),
    GameLevel(
      id: 2,
      difficulty: 2,
      title: '职场基础',
      description: '基本的工作流程排序',
      items: [
        '接收任务',
        '制定计划',
        '执行任务',
        '检查成果',
        '提交报告',
      ],
    ),
    GameLevel(
      id: 3,
      difficulty: 3,
      title: '职场进阶',
      description: '复杂的工作流程排序',
      items: [
        '客户需求分析',
        '方案设计',
        '方案实施',
        '质量检查',
        '客户验收',
        '项目总结',
      ],
    ),
    GameLevel(
      id: 4,
      difficulty: 4,
      title: '职场熟练',
      description: '多任务工作流程排序',
      items: [
        '优先级排序',
        '时间分配',
        '并行处理',
        '进度跟踪',
        '资源协调',
        '结果评估',
      ],
    ),
    GameLevel(
      id: 5,
      difficulty: 5,
      title: '职场独立',
      description: '复杂项目的完整流程排序',
      items: [
        '项目启动',
        '需求调研',
        '计划制定',
        '团队分工',
        '执行实施',
        '风险管理',
        '质量控制',
        '项目验收',
        '经验总结',
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
    _shuffledItems = List.from(_currentLevel.items)..shuffle();
    _userOrder = [];
    _isGameComplete = false;
    _isCorrect = false;
    _showHint = false;
  }

  String _getHint() {
    switch (_currentDifficulty) {
      case 1:
        return '提示：按照职场的基本流程顺序排列，从上班到开始工作';
      case 2:
        return '提示：按照工作任务的处理流程排列，从接收到提交';
      case 3:
        return '提示：按照项目的执行流程排列，从需求分析到总结';
      case 4:
        return '提示：按照多任务管理的流程排列，从优先级到评估';
      case 5:
        return '提示：按照复杂项目的完整流程排列，从启动到验收';
      default:
        return '提示：按照合理的工作流程顺序排列';
    }
  }

  void _selectItem(String item) {
    if (!_isGameComplete && !_userOrder.contains(item)) {
      setState(() {
        _userOrder.add(item);

        if (_userOrder.length == _currentLevel.items.length) {
          _checkAnswer();
        }
      });
    }
  }

  void _removeItem(String item) {
    if (!_isGameComplete && _userOrder.contains(item)) {
      setState(() {
        _userOrder.remove(item);
      });
    }
  }

  void _checkAnswer() {
    _isGameComplete = true;
    _isCorrect = _userOrder.join(',') == _currentLevel.items.join(',');
    
    if (_isCorrect) {
      // 计算积分：根据难度级别计算积分
      int score = _currentDifficulty * 100;
      
      // 保存游戏进度和积分
      final gameProvider = Provider.of<GameProvider>(context, listen: false);
      gameProvider.updateGameScore('文字排序游戏', score);
      gameProvider.updateGameLevel('文字排序游戏', _currentDifficulty);
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

  String _getPositiveFeedback() {
    final feedbacks = [
      '你做得很棒！继续加油！',
      '太棒了！你是排序小能手！',
      '非常好！你的逻辑思维真强！',
      '优秀！你正在进步！',
      '完美！你排对了这个顺序！',
      '厉害！你掌握了这个工作流程！',
      '超棒！你是职场排序达人！',
      '好样的！你离成功更近了！',
    ];
    return feedbacks[DateTime.now().millisecond % feedbacks.length];
  }

  String _getEncouragingFeedback() {
    final feedbacks = [
      '没关系，再试一次吧！你可以做到的！',
      '不要气馁，排序需要练习！',
      '再仔细想想工作流程，你会排对的！',
      '排序就是不断调整的过程，继续努力！',
      '你已经很接近了，再试一次！',
      '错误是学习的机会，加油！',
      '慢慢来，你会掌握的！',
      '相信自己，你有这个能力！',
    ];
    return feedbacks[DateTime.now().millisecond % feedbacks.length];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('文字排序游戏'),
        backgroundColor: const Color(0xFF2196F3),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 32),
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
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _showHint = !_showHint;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2196F3),
              ),
              child: Text(_showHint ? '隐藏提示' : '显示提示'),
            ),
            if (_showHint)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Container(
                  padding: const EdgeInsets.all(12.0),
                  margin: const EdgeInsets.symmetric(horizontal: 24.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: const Color(0xFF2196F3),
                      width: 2.0,
                    ),
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
            const SizedBox(height: 32),
            
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
                    value: (_currentTaskIndex + 1) / 1,
                    backgroundColor: const Color(0xFFF5F5F5),
                    valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF4CAF50)),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '第 ${_currentTaskIndex + 1} 题 / 共 1 题',
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Color(0xFF666666),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // 待排序的项目
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 2,
                ),
                itemCount: _shuffledItems.length,
                itemBuilder: (context, index) {
                  final item = _shuffledItems[index];
                  return GestureDetector(
                    onTap: () => _selectItem(item),
                    child: Card(
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      color: _userOrder.contains(item) 
                          ? const Color(0xFFE3F2FD)
                          : Colors.white,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 18.0,
                              color: Color(0xFF333333),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 32),

            // 用户排序结果
            Text(
              '当前排序:',
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
              children: _userOrder.map((item) {
                return GestureDetector(
                  onTap: () => _removeItem(item),
                  child: Chip(
                    label: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: const Color(0xFF2196F3),
                    deleteIcon: const Icon(Icons.remove_circle),
                    onDeleted: () => _removeItem(item),
                  ),
                );
              }).toList(),
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
                      _isCorrect ? '排序正确！' : '排序错误',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: _isCorrect ? const Color(0xFF2E7D32) : const Color(0xFFC62828),
                      ),
                      textAlign: TextAlign.center,
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
                        onPressed: _restartLevel,
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
