import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:autism_work_integration_tool/src/models/game_level.dart';
import 'package:autism_work_integration_tool/src/providers/game_provider.dart';

class NumberCalculationGame extends StatefulWidget {
  const NumberCalculationGame({super.key});

  @override
  State<NumberCalculationGame> createState() => _NumberCalculationGameState();
}

class _NumberCalculationGameState extends State<NumberCalculationGame> {
  late GameLevel _currentLevel;
  int _currentDifficulty = 1;
  String _question = '';
  int _correctAnswer = 0;
  int _userAnswer = 0;
  bool _isGameComplete = false;
  bool _isCorrect = false;
  bool _showHint = false;
  int _currentTaskIndex = 0;

  // 提示信息
  final List<List<String>> _hints = [
    // 难度级别 1
    [
      '提示：本月工资 = 出勤天数 × 日薪',
      '提示：一天工资 = 工作小时 × 时薪',
      '提示：本周工资 = 出勤天数 × 日薪',
    ],
    // 难度级别 2
    [
      '提示：实发工资 = 基本工资 + 奖金 - 税费',
      '提示：总工资 = 基本工资 + 加班小时 × 加班费',
      '提示：日薪 = 月薪 ÷ 22',
    ],
    // 难度级别 3
    [
      '提示：总销售额 = 三周销售额之和',
      '提示：总采购额 = 商品数量 × 单价',
      '提示：每人支付 = 总费用 ÷ 人数',
    ],
    // 难度级别 4
    [
      '提示：实际销售额 = 总销售额 - 退货金额',
      '提示：本月销售额 = 上月销售额 + 增长金额',
      '提示：折后价格 = 原价 - 折扣金额',
    ],
    // 难度级别 5
    [
      '提示：净利润 = (收入 - 成本) × (1 - 税率)',
      '提示：本息和 = 投资金额 + 收益金额',
      '提示：年薪 = 月薪 × 12 + 年终奖',
    ],
  ];

  final List<GameLevel> _levels = [
    GameLevel(
      id: 1,
      difficulty: 1,
      title: '职场入门',
      description: '简单的考勤核算',
      items: [],
    ),
    GameLevel(
      id: 2,
      difficulty: 2,
      title: '职场基础',
      description: '基本的薪资计算',
      items: [],
    ),
    GameLevel(
      id: 3,
      difficulty: 3,
      title: '职场进阶',
      description: '办公数据统计',
      items: [],
    ),
    GameLevel(
      id: 4,
      difficulty: 4,
      title: '职场熟练',
      description: '复杂的数据分析',
      items: [],
    ),
    GameLevel(
      id: 5,
      difficulty: 5,
      title: '职场独立',
      description: '综合财务计算',
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
    _generateQuestion();
    _userAnswer = 0;
    _isGameComplete = false;
    _isCorrect = false;
    _showHint = false;
  }

  void _generateQuestion() {
    final random = _currentTaskIndex % 3;
    _currentTaskIndex++;
    switch (_currentDifficulty) {
      case 1:
        // 简单的考勤核算
        switch (random) {
          case 0:
            final days = 22 + (DateTime.now().millisecond % 5);
            final dailyWage = 100 + (DateTime.now().millisecond % 50);
            _correctAnswer = days * dailyWage;
            _question = '员工本月出勤 $days 天，日薪 $dailyWage 元，本月工资是多少？';
            break;
          case 1:
            final hours = 8 + (DateTime.now().millisecond % 4);
            final hourlyWage = 15 + (DateTime.now().millisecond % 10);
            _correctAnswer = hours * hourlyWage;
            _question = '员工每天工作 $hours 小时，时薪 $hourlyWage 元，一天工资是多少？';
            break;
          case 2:
            final days = 5 + (DateTime.now().millisecond % 2);
            final dailyWage = 120 + (DateTime.now().millisecond % 60);
            _correctAnswer = days * dailyWage;
            _question = '员工本周出勤 $days 天，日薪 $dailyWage 元，本周工资是多少？';
            break;
        }
        break;
      case 2:
        // 基本的薪资计算
        switch (random) {
          case 0:
            final basicSalary = 3000 + (DateTime.now().millisecond % 1000);
            final bonus = 500 + (DateTime.now().millisecond % 500);
            final tax = (basicSalary + bonus) ~/ 20;
            _correctAnswer = basicSalary + bonus - tax;
            _question = '员工基本工资 $basicSalary 元，奖金 $bonus 元，税率 5%，实发工资是多少？';
            break;
          case 1:
            final basicSalary = 2500 + (DateTime.now().millisecond % 800);
            final overtime = 10 + (DateTime.now().millisecond % 10);
            final overtimeRate = 20 + (DateTime.now().millisecond % 10);
            _correctAnswer = basicSalary + overtime * overtimeRate;
            _question = '员工基本工资 $basicSalary 元，加班 $overtime 小时，加班费 $overtimeRate 元/小时，总工资是多少？';
            break;
          case 2:
            final monthlySalary = 3500 + (DateTime.now().millisecond % 1200);
            _correctAnswer = monthlySalary ~/ 22;
            _question = '员工月薪 $monthlySalary 元，按22个工作日计算，日薪是多少？';
            break;
        }
        break;
      case 3:
        // 办公数据统计
        switch (random) {
          case 0:
            final sales1 = 1000 + (DateTime.now().millisecond % 500);
            final sales2 = 1200 + (DateTime.now().millisecond % 600);
            final sales3 = 800 + (DateTime.now().millisecond % 400);
            _correctAnswer = sales1 + sales2 + sales3;
            _question = '三周销售额分别为 $sales1 元、$sales2 元、$sales3 元，总销售额是多少？';
            break;
          case 1:
            final items = 50 + (DateTime.now().millisecond % 30);
            final price = 20 + (DateTime.now().millisecond % 15);
            _correctAnswer = items * price;
            _question = '公司采购 $items 件商品，每件 $price 元，总采购额是多少？';
            break;
          case 2:
            final total = 3000 + (DateTime.now().millisecond % 2000);
            final people = 5 + (DateTime.now().millisecond % 5);
            _correctAnswer = total ~/ people;
            _question = '团队总费用 $total 元，由 $people 人平摊，每人需要支付多少？';
            break;
        }
        break;
      case 4:
        // 复杂的数据分析
        switch (random) {
          case 0:
            final total = 5000 + (DateTime.now().millisecond % 2000);
            final returnRate = 5 + (DateTime.now().millisecond % 10);
            _correctAnswer = total - (total * returnRate ~/ 100);
            _question = '总销售额 $total 元，退货率 $returnRate%，实际销售额是多少？';
            break;
          case 1:
            final previous = 4000 + (DateTime.now().millisecond % 1500);
            final growthRate = 5 + (DateTime.now().millisecond % 15);
            _correctAnswer = previous + (previous * growthRate ~/ 100);
            _question = '上月销售额 $previous 元，本月增长 $growthRate%，本月销售额是多少？';
            break;
          case 2:
            final total = 6000 + (DateTime.now().millisecond % 2500);
            final discountRate = 10 + (DateTime.now().millisecond % 15);
            _correctAnswer = total - (total * discountRate ~/ 100);
            _question = '商品原价 $total 元，打 $discountRate% 折，折后价格是多少？';
            break;
        }
        break;
      case 5:
        // 综合财务计算
        switch (random) {
          case 0:
            final revenue = 10000 + (DateTime.now().millisecond % 5000);
            final cost = 6000 + (DateTime.now().millisecond % 3000);
            final taxRate = 13;
            _correctAnswer = (revenue - cost) * (100 - taxRate) ~/ 100;
            _question = '收入 $revenue 元，成本 $cost 元，税率 13%，净利润是多少？';
            break;
          case 1:
            final investment = 8000 + (DateTime.now().millisecond % 4000);
            final returnRate = 8 + (DateTime.now().millisecond % 12);
            _correctAnswer = investment + (investment * returnRate ~/ 100);
            _question = '投资 $investment 元，年化收益率 $returnRate%，一年后本息和是多少？';
            break;
          case 2:
            final monthlySalary = 5000 + (DateTime.now().millisecond % 3000);
            final annualBonus = 12000 + (DateTime.now().millisecond % 8000);
            _correctAnswer = monthlySalary * 12 + annualBonus;
            _question = '员工月薪 $monthlySalary 元，年终奖 $annualBonus 元，年薪是多少？';
            break;
        }
        break;
    }
  }

  void _checkAnswer() {
    _isGameComplete = true;
    _isCorrect = _userAnswer == _correctAnswer;
    
    if (_isCorrect) {
      // 计算积分：根据难度级别计算积分
      int score = _currentDifficulty * 100;
      
      // 保存游戏进度和积分
      final gameProvider = Provider.of<GameProvider>(context, listen: false);
      gameProvider.updateGameScore('数字计算游戏', score);
      gameProvider.updateGameLevel('数字计算游戏', _currentDifficulty);
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
      '太棒了！你是计算小能手！',
      '非常好！你的计算能力真强！',
      '优秀！你正在进步！',
      '完美！你解决了这个问题！',
      '厉害！你掌握了这个计算技巧！',
      '超棒！你是职场计算达人！',
      '好样的！你离成功更近了！',
    ];
    return feedbacks[DateTime.now().millisecond % feedbacks.length];
  }

  String _getEncouragingFeedback() {
    final feedbacks = [
      '没关系，再试一次吧！你可以做到的！',
      '不要气馁，计算需要练习！',
      '再仔细算一遍，你会发现问题的！',
      '计算就是不断练习的过程，继续努力！',
      '你已经很接近了，再试一次！',
      '错误是学习的机会，加油！',
      '慢慢来，你会掌握的！',
      '相信自己，你有这个能力！',
    ];
    return feedbacks[DateTime.now().millisecond % feedbacks.length];
  }

  String _getHint() {
    final difficultyIndex = _currentDifficulty - 1;
    final hintIndex = (_currentTaskIndex - 1) % 3;
    return _hints[difficultyIndex][hintIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('数字计算游戏'),
        backgroundColor: const Color(0xFFFF9800),
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

            // 问题展示
            Container(
              padding: const EdgeInsets.all(24.0),
              margin: const EdgeInsets.symmetric(vertical: 16.0),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF3E0),
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                  color: const Color(0xFFFF9800),
                  width: 2.0,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    _question,
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
                      backgroundColor: const Color(0xFFFF9800),
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
                    value: ((_currentTaskIndex - 1) % 3 + 1) / 3,
                    backgroundColor: const Color(0xFFF5F5F5),
                    valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF4CAF50)),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '第 ${((_currentTaskIndex - 1) % 3 + 1)} 题 / 共 3 题',
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Color(0xFF666666),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // 数字键盘
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 12.0,
                childAspectRatio: 2,
              ),
              itemCount: 12,
              itemBuilder: (context, index) {
                final value = index == 9 ? 0 : index + 1;
                final isDelete = index == 10;
                final isSubmit = index == 11;

                return ElevatedButton(
                  onPressed: _isGameComplete
                      ? null
                      : () {
                          if (isDelete) {
                            setState(() {
                              _userAnswer = _userAnswer ~/ 10;
                            });
                          } else if (isSubmit) {
                            _checkAnswer();
                          } else {
                            setState(() {
                              _userAnswer = _userAnswer * 10 + value;
                            });
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDelete
                        ? const Color(0xFFF44336)
                        : isSubmit
                            ? const Color(0xFF4CAF50)
                            : const Color(0xFFFF9800),
                    padding: const EdgeInsets.all(16.0),
                  ),
                  child: Text(
                    isDelete
                        ? '删除'
                        : isSubmit
                            ? '提交'
                            : '$value',
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 32),

            // 用户答案
            Text(
              '您的答案: $_userAnswer',
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
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
                      _isCorrect ? '计算正确！' : '计算错误',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: _isCorrect ? const Color(0xFF2E7D32) : const Color(0xFFC62828),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    if (!_isCorrect)
                      Text(
                        '正确答案是 $_correctAnswer',
                        style: const TextStyle(
                          fontSize: 18.0,
                          color: Color(0xFFC62828),
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
                    backgroundColor: const Color(0xFFFFB74D),
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
