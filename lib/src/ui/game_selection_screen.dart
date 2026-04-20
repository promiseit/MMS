import 'package:flutter/material.dart';
import 'package:autism_work_integration_tool/src/games/text_sorting_game.dart';
import 'package:autism_work_integration_tool/src/games/number_calculation_game.dart';
import 'package:autism_work_integration_tool/src/games/english_spelling_game.dart';
import 'package:autism_work_integration_tool/src/games/programming_game.dart';
import 'package:autism_work_integration_tool/src/games/mixed_mode_game.dart';
import 'package:autism_work_integration_tool/src/ui/game_guide_screen.dart';

class GameSelectionScreen extends StatelessWidget {
  const GameSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          const Text(
            '选择游戏类型',
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
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
                _buildGameCard(
                  context,
                  title: '文字排序游戏',
                  description: '职场指令排序、工作流程排序',
                  icon: Icons.sort_by_alpha,
                  color: const Color(0xFF2196F3),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TextSortingGame(),
                      ),
                    );
                  },
                  onGuideTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GameGuideScreen(
                          gameName: '文字排序游戏',
                          description: '通过排序职场指令和工作流程，培养逻辑思维和工作顺序感。',
                          steps: [
                            '点击屏幕上的任务卡片，将其添加到排序区域',
                            '按照正确的工作流程顺序排列任务',
                            '如果排序错误，可以点击排序区域中的任务将其移除',
                            '完成排序后，系统会自动检查答案',
                          ],
                          tips: '先理解每个任务的含义，再按照逻辑顺序排列。如果不确定，可以尝试不同的顺序，系统会给予反馈。',
                        ),
                      ),
                    );
                  },
                ),
                _buildGameCard(
                  context,
                  title: '数字计算游戏',
                  description: '考勤核算、薪资计算、办公数据统计',
                  icon: Icons.calculate,
                  color: const Color(0xFFFF9800),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NumberCalculationGame(),
                      ),
                    );
                  },
                  onGuideTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GameGuideScreen(
                          gameName: '数字计算游戏',
                          description: '通过解决职场中的数学问题，提高计算能力和数据处理能力。',
                          steps: [
                            '阅读屏幕上的数学问题',
                            '使用屏幕下方的数字键盘输入答案',
                            '点击删除按钮可以删除输入的数字',
                            '点击提交按钮检查答案是否正确',
                          ],
                          tips: '仔细阅读问题，确保理解题意后再计算。如果计算错误，系统会显示正确答案，帮助你学习。',
                        ),
                      ),
                    );
                  },
                ),
                _buildGameCard(
                  context,
                  title: '英文拼接游戏',
                  description: '职场常用词汇、办公英文短语',
                  icon: Icons.language,
                  color: const Color(0xFF9C27B0),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EnglishSpellingGame(),
                      ),
                    );
                  },
                  onGuideTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GameGuideScreen(
                          gameName: '英文拼接游戏',
                          description: '通过拼职场英文词汇，提高英文词汇量和拼写能力。',
                          steps: [
                            '阅读屏幕上的提示，了解要拼写的单词含义',
                            '点击屏幕上的字母，将其添加到拼写区域',
                            '如果拼写错误，可以点击删除按钮删除最后一个字母',
                            '完成拼写后，系统会自动检查答案',
                          ],
                          tips: '注意字母的顺序，按照正确的拼写顺序选择字母。如果不确定，可以尝试不同的组合。',
                        ),
                      ),
                    );
                  },
                ),
                _buildGameCard(
                  context,
                  title: '简单编程游戏',
                  description: '工作自动化流程积木编程',
                  icon: Icons.code,
                  color: const Color(0xFFF44336),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProgrammingGame(),
                      ),
                    );
                  },
                  onGuideTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GameGuideScreen(
                          gameName: '简单编程游戏',
                          description: '通过积木式编程，学习基本的编程逻辑和工作自动化能力。',
                          steps: [
                            '阅读屏幕上的编程任务',
                            '点击屏幕上的代码块，将其添加到编程区域',
                            '按照正确的顺序排列代码块',
                            '点击提交按钮检查代码是否正确',
                          ],
                          tips: '先理解任务需求，再按照逻辑顺序排列代码块。注意代码的缩进和顺序，这对编程非常重要。',
                        ),
                      ),
                    );
                  },
                ),
                _buildGameCard(
                  context,
                  title: '混合模式游戏',
                  description: '职场综合任务处理',
                  icon: Icons.category,
                  color: const Color(0xFF4CAF50),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MixedModeGame(),
                      ),
                    );
                  },
                  onGuideTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GameGuideScreen(
                          gameName: '混合模式游戏',
                          description: '综合练习职场中的各种任务，提高综合处理能力。',
                          steps: [
                            '阅读屏幕上的任务类型和内容',
                            '在输入框中输入答案',
                            '点击提交按钮检查答案是否正确',
                            '完成当前任务后，点击下一题继续',
                          ],
                          tips: '这是一个综合练习，包含了排序、计算、拼写和编程等多种任务。仔细阅读任务要求，按照提示完成。',
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGameCard(
    BuildContext context,
    {required String title,
    required String description,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    required VoidCallback onGuideTap}) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 72.0,
              color: color,
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: const TextStyle(
                fontSize: 18.0,
                color: Color(0xFF666666),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: onGuideTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color.withOpacity(0.8),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: const Text('操作指南'),
                ),
                ElevatedButton(
                  onPressed: onTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: const Text('开始游戏'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
