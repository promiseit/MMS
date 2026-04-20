import 'package:flutter/material.dart';

class SocialSkillsScreen extends StatefulWidget {
  const SocialSkillsScreen({super.key});

  @override
  State<SocialSkillsScreen> createState() => _SocialSkillsScreenState();
}

class _SocialSkillsScreenState extends State<SocialSkillsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('社交技能练习'),
        backgroundColor: const Color(0xFF4CAF50),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            const Text(
              '职场社交技能练习',
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            const Text(
              '通过模拟场景练习，提高职场社交能力',
              style: TextStyle(
                fontSize: 18.0,
                color: Color(0xFF666666),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 20.0,
                mainAxisSpacing: 20.0,
                children: [
                  _buildSkillCard(
                    context,
                    title: '职场问候',
                    description: '练习与同事和上司的问候方式',
                    icon: Icons.waving_hand,
                    color: const Color(0xFF2196F3),
                    scenarios: [
                      {
                        'scenario': '早上上班时，你遇到了你的上司',
                        'options': [
                          '低头走过，不打招呼',
                          '说"早"，然后继续走',
                          '微笑着说"早上好，张经理！今天看起来不错。"',
                        ],
                        'correctIndex': 2,
                        'feedback': '正确！礼貌的问候能建立良好的职场关系。',
                      },
                      {
                        'scenario': '你在走廊遇到了一位新同事',
                        'options': [
                          '假装没看见',
                          '简单点个头',
                          '主动介绍自己："你好，我是[你的名字]，很高兴认识你！"',
                        ],
                        'correctIndex': 2,
                        'feedback': '正确！主动介绍自己有助于建立新的职场关系。',
                      },
                    ],
                  ),
                  _buildSkillCard(
                    context,
                    title: '会议参与',
                    description: '练习在会议中表达自己的观点',
                    icon: Icons.meeting_room,
                    color: const Color(0xFFFF9800),
                    scenarios: [
                      {
                        'scenario': '在会议中，你有一个好想法',
                        'options': [
                          '保持沉默，不发言',
                          '直接打断别人的发言',
                          '等待合适的时机，说"我有一个想法，不知道是否合适..."',
                        ],
                        'correctIndex': 2,
                        'feedback': '正确！选择合适的时机发言，既尊重他人又能表达自己的观点。',
                      },
                      {
                        'scenario': '别人对你的观点提出反对意见',
                        'options': [
                          '争论并坚持自己的观点',
                          '立刻放弃自己的观点',
                          '认真倾听，然后说"我理解你的观点，让我们考虑一下..."',
                        ],
                        'correctIndex': 2,
                        'feedback': '正确！尊重他人的意见，同时保持自己的立场，是职场沟通的重要技巧。',
                      },
                    ],
                  ),
                  _buildSkillCard(
                    context,
                    title: '团队合作',
                    description: '练习与团队成员的协作沟通',
                    icon: Icons.people,
                    color: const Color(0xFF4CAF50),
                    scenarios: [
                      {
                        'scenario': '团队任务中，你发现队友的工作有问题',
                        'options': [
                          '直接指责队友',
                          '忽略问题，自己完成',
                          '委婉地说"我注意到这里可能需要调整，我们一起看看？"',
                        ],
                        'correctIndex': 2,
                        'feedback': '正确！委婉地指出问题，邀请合作解决，有助于保持团队和谐。',
                      },
                      {
                        'scenario': '队友完成了一项困难的任务',
                        'options': [
                          '什么都不说',
                          '简单说"不错"',
                          '真诚地说"你做得太棒了！这对团队帮助很大。"',
                        ],
                        'correctIndex': 2,
                        'feedback': '正确！真诚的表扬能增强团队凝聚力和积极性。',
                      },
                    ],
                  ),
                  _buildSkillCard(
                    context,
                    title: '请求帮助',
                    description: '练习如何礼貌地请求同事帮助',
                    icon: Icons.help,
                    color: const Color(0xFF9C27B0),
                    scenarios: [
                      {
                        'scenario': '你遇到了技术问题，需要同事帮助',
                        'options': [
                          '直接说"帮我弄一下这个"',
                          '不说，自己琢磨',
                          '礼貌地说"你好，我遇到了一个问题，不知道你是否有时间帮我看一下？"',
                        ],
                        'correctIndex': 2,
                        'feedback': '正确！礼貌地请求帮助，尊重对方的时间，更容易获得支持。',
                      },
                      {
                        'scenario': '同事帮助你解决了问题',
                        'options': [
                          '什么都不说',
                          '简单说"谢谢"',
                          '真诚地说"非常感谢你的帮助，这对我来说意义重大。"',
                        ],
                        'correctIndex': 2,
                        'feedback': '正确！真诚的感谢能建立良好的人际关系。',
                      },
                    ],
                  ),
                  _buildSkillCard(
                    context,
                    title: '接受反馈',
                    description: '练习如何接受和回应工作反馈',
                    icon: Icons.feedback,
                    color: const Color(0xFFF44336),
                    scenarios: [
                      {
                        'scenario': '上司对你的工作提出了批评',
                        'options': [
                          '辩解并反驳',
                          '沉默不语，情绪低落',
                          '认真倾听，说"我理解你的反馈，我会努力改进。"',
                        ],
                        'correctIndex': 2,
                        'feedback': '正确！积极接受反馈，表现出改进的意愿，有助于职业成长。',
                      },
                      {
                        'scenario': '同事对你的工作提出了建议',
                        'options': [
                          '忽略建议',
                          '感谢但不采纳',
                          '认真考虑，说"谢谢你的建议，我会尝试这样做。"',
                        ],
                        'correctIndex': 2,
                        'feedback': '正确！开放地接受建议，展示你的学习态度。',
                      },
                    ],
                  ),
                  _buildSkillCard(
                    context,
                    title: '职场礼仪',
                    description: '学习基本的职场礼仪和行为规范',
                    icon: Icons.person,
                    color: const Color(0xFF795548),
                    scenarios: [
                      {
                        'scenario': '在办公室使用手机',
                        'options': [
                          '大声打电话，不考虑他人',
                          '一直看手机，不参与工作',
                          '保持安静，只在必要时使用',
                        ],
                        'correctIndex': 2,
                        'feedback': '正确！在办公室保持安静，尊重他人的工作环境。',
                      },
                      {
                        'scenario': '使用公共空间（如厨房）',
                        'options': [
                          '用完不打扫，留下垃圾',
                          '随意使用他人的物品',
                          '保持清洁，尊重他人的物品',
                        ],
                        'correctIndex': 2,
                        'feedback': '正确！保持公共空间的整洁，尊重他人的物品，是基本的职场礼仪。',
                      },
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

  Widget _buildSkillCard(
    BuildContext context,
    {required String title,
    required String description,
    required IconData icon,
    required Color color,
    required List<Map<String, dynamic>> scenarios}) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: InkWell(
        onTap: () {
          // 导航到具体的技能练习场景
          _showSkillExercise(context, title, scenarios);
        },
        borderRadius: BorderRadius.circular(16.0),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 64.0,
                color: color,
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Color(0xFF666666),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSkillExercise(BuildContext context, String skillName, List<Map<String, dynamic>> scenarios) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SocialSkillExerciseScreen(
          skillName: skillName,
          scenarios: scenarios,
        ),
      ),
    );
  }
}

class SocialSkillExerciseScreen extends StatefulWidget {
  final String skillName;
  final List<Map<String, dynamic>> scenarios;

  const SocialSkillExerciseScreen({
    Key? key,
    required this.skillName,
    required this.scenarios,
  }) : super(key: key);

  @override
  State<SocialSkillExerciseScreen> createState() => _SocialSkillExerciseScreenState();
}

class _SocialSkillExerciseScreenState extends State<SocialSkillExerciseScreen> {
  int _currentScenarioIndex = 0;
  bool _showFeedback = false;
  int _selectedOptionIndex = -1;
  int _correctCount = 0;

  @override
  Widget build(BuildContext context) {
    final currentScenario = widget.scenarios[_currentScenarioIndex];
    final isLastScenario = _currentScenarioIndex == widget.scenarios.length - 1;

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.skillName}练习'),
        backgroundColor: const Color(0xFF4CAF50),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Text(
              '场景 ${_currentScenarioIndex + 1}/${widget.scenarios.length}',
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(20.0),
              margin: const EdgeInsets.symmetric(vertical: 16.0),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                  color: const Color(0xFF4CAF50),
                  width: 2.0,
                ),
              ),
              child: Text(
                currentScenario['scenario'],
                style: const TextStyle(
                  fontSize: 18.0,
                  color: Color(0xFF333333),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 32),
            Expanded(
              child: ListView.builder(
                itemCount: currentScenario['options'].length,
                itemBuilder: (context, index) {
                  final isSelected = _selectedOptionIndex == index;
                  final isCorrect = index == currentScenario['correctIndex'];
                  final isWrong = _showFeedback && _selectedOptionIndex == index && !isCorrect;

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ElevatedButton(
                      onPressed: _showFeedback ? null : () => _selectOption(index),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isSelected
                            ? (isCorrect ? const Color(0xFF4CAF50) : const Color(0xFFF44336))
                            : Colors.white,
                        foregroundColor: isSelected ? Colors.white : const Color(0xFF333333),
                        side: BorderSide(
                          color: isSelected
                              ? (isCorrect ? const Color(0xFF4CAF50) : const Color(0xFFF44336))
                              : const Color(0xFFE0E0E0),
                          width: 2.0,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      child: Text(
                        currentScenario['options'][index],
                        style: const TextStyle(fontSize: 16.0),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              ),
            ),
            if (_showFeedback)
              Container(
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.symmetric(vertical: 16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFE3F2FD),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Text(
                  currentScenario['feedback'],
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Color(0xFF1976D2),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (_currentScenarioIndex > 0)
                  ElevatedButton(
                    onPressed: () => _previousScenario(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF9E9E9E),
                    ),
                    child: const Text('上一题'),
                  ),
                if (_showFeedback)
                  ElevatedButton(
                    onPressed: isLastScenario ? _finishExercise : _nextScenario,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4CAF50),
                    ),
                    child: Text(isLastScenario ? '完成练习' : '下一题'),
                  ),
              ],
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  void _selectOption(int index) {
    setState(() {
      _selectedOptionIndex = index;
      _showFeedback = true;
      if (index == widget.scenarios[_currentScenarioIndex]['correctIndex']) {
        _correctCount++;
      }
    });
  }

  void _nextScenario() {
    setState(() {
      _currentScenarioIndex++;
      _showFeedback = false;
      _selectedOptionIndex = -1;
    });
  }

  void _previousScenario() {
    setState(() {
      _currentScenarioIndex--;
      _showFeedback = false;
      _selectedOptionIndex = -1;
      // 重新计算正确答案数
      _correctCount = 0;
      for (int i = 0; i < _currentScenarioIndex; i++) {
        // 这里简化处理，实际应该记录每个场景的回答情况
      }
    });
  }

  void _finishExercise() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('练习完成'),
        content: Text(
          '你完成了${widget.skillName}的练习！\n\n' 
          '正确答案: $_correctCount/${widget.scenarios.length}\n\n' 
          '继续练习，你会变得越来越好！',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }
}
