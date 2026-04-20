import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:autism_work_integration_tool/src/models/game_level.dart';
import 'package:autism_work_integration_tool/src/models/game_data.dart';
import 'package:autism_work_integration_tool/src/providers/game_provider.dart';
import 'package:autism_work_integration_tool/src/services/data_service.dart';
import 'package:autism_work_integration_tool/src/services/logger_service.dart';

class EnglishSpellingGame extends StatefulWidget {
  const EnglishSpellingGame({super.key});

  @override
  State<EnglishSpellingGame> createState() => _EnglishSpellingGameState();
}

class _EnglishSpellingGameState extends State<EnglishSpellingGame> {
  List<GameLevelData> _gameLevels = [];
  GameLevelData? _currentLevel;
  int _currentDifficulty = 1;
  String _targetWord = '';
  String _hint = '';
  List<String> _shuffledLetters = [];
  String _userInput = '';
  bool _isGameComplete = false;
  bool _isCorrect = false;
  bool _showHint = false;
  bool _isLoading = true;
  int _currentTaskIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadGameData();
  }

  Future<void> _loadGameData() async {
    setState(() {
      _isLoading = true;
    });
    
    _gameLevels = await DataService.loadEnglishSpellingWords();
    
    if (_gameLevels.isNotEmpty) {
      _loadLevel(_currentDifficulty);
    }
    
    setState(() {
      _isLoading = false;
    });
  }

  void _loadLevel(int difficulty) {
    if (_gameLevels.isEmpty) return;
    
    _currentLevel = _gameLevels.firstWhere(
      (level) => level.difficulty == difficulty,
      orElse: () => _gameLevels.first,
    );
    
    _currentTaskIndex = 0;
    _generateWord();
    _userInput = '';
    _isGameComplete = false;
    _isCorrect = false;
    _showHint = false;
  }

  void _generateWord() {
    if (_currentLevel == null || _currentLevel!.words.isEmpty) return;
    
    final index = _currentTaskIndex % _currentLevel!.words.length;
    _currentTaskIndex++;
    final wordItem = _currentLevel!.words[index];
    _targetWord = wordItem.word;
    _hint = wordItem.hint;
    _shuffledLetters = _targetWord.split('')..shuffle();
  }

  void _selectLetter(String letter) {
    if (!_isGameComplete && _shuffledLetters.contains(letter)) {
      setState(() {
        _userInput += letter;
        _shuffledLetters.remove(letter);

        if (_userInput.length == _targetWord.length) {
          _checkAnswer();
        }
      });
    }
  }

  void _removeLastLetter() {
    if (!_isGameComplete && _userInput.isNotEmpty) {
      setState(() {
        final lastLetter = _userInput[_userInput.length - 1];
        _shuffledLetters.add(lastLetter);
        _userInput = _userInput.substring(0, _userInput.length - 1);
      });
    }
  }

  void _checkAnswer() {
    setState(() {
      _isGameComplete = true;
      _isCorrect = _userInput == _targetWord;
    });
    
    if (_isCorrect) {
      final score = _currentDifficulty * 100;
      
      final gameProvider = Provider.of<GameProvider>(context, listen: false);
      gameProvider.updateGameScore('英文拼写游戏', score);
      gameProvider.updateGameLevel('英文拼写游戏', _currentDifficulty);
      
      LoggerService.debug('英语拼写游戏: 答对 +$score 分');
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
      '太棒了！你是英文拼写小能手！',
      '非常好！你的英文水平真高！',
      '优秀！你正在进步！',
      '完美！你拼对了这个单词！',
      '厉害！你掌握了这个英文词汇！',
      '超棒！你是职场英文达人！',
      '好样的！你离成功更近了！',
    ];
    return feedbacks[DateTime.now().millisecond % feedbacks.length];
  }

  String _getEncouragingFeedback() {
    final feedbacks = [
      '没关系，再试一次吧！你可以做到的！',
      '不要气馁，英文拼写需要练习！',
      '再仔细看看字母，你会拼对的！',
      '拼写就是不断练习的过程，继续努力！',
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
        title: const Text('英文拼写游戏'),
        backgroundColor: const Color(0xFF4CAF50),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildGameContent(),
    );
  }

  Widget _buildGameContent() {
    if (_gameLevels.isEmpty || _currentLevel == null) {
      return const Center(
        child: Text('无法加载游戏数据'),
      );
    }
    
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Text(
            _currentLevel!.title,
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _currentLevel!.description,
            style: const TextStyle(
              fontSize: 16.0,
              color: Color(0xFF666666),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),

          Container(
            padding: const EdgeInsets.all(16.0),
            margin: const EdgeInsets.symmetric(vertical: 16.0),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                color: const Color(0xFF4CAF50),
                width: 2.0,
              ),
            ),
            child: Column(
              children: [
                Text(
                  '提示: $_hint',
                  style: const TextStyle(
                    fontSize: 18.0,
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
                    backgroundColor: const Color(0xFF4CAF50),
                  ),
                  child: Text(_showHint ? '隐藏单词长度' : '显示单词长度'),
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
                        '单词长度: ${_targetWord.length} 个字母',
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
                  value: ((_currentTaskIndex - 1) % _currentLevel!.words.length + 1) / _currentLevel!.words.length,
                  backgroundColor: const Color(0xFFF5F5F5),
                  valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF4CAF50)),
                ),
                const SizedBox(height: 8),
                Text(
                  '第 ${((_currentTaskIndex - 1) % _currentLevel!.words.length + 1)} 题 / 共 ${_currentLevel!.words.length} 题',
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Color(0xFF666666),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          Text(
            '请拼出 ${_targetWord.length} 个字母的单词:',
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),

          const SizedBox(height: 16),

          Container(
            padding: const EdgeInsets.all(24.0),
            margin: const EdgeInsets.symmetric(vertical: 16.0),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                color: const Color(0xFF4CAF50),
                width: 2.0,
              ),
            ),
            child: Text(
              _userInput,
              style: const TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 32),

          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 12.0,
                childAspectRatio: 1.5,
              ),
              itemCount: _shuffledLetters.length,
              itemBuilder: (context, index) {
                final letter = _shuffledLetters[index];
                return GestureDetector(
                  onTap: () => _selectLetter(letter),
                  child: Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    color: const Color(0xFFA5D6A7),
                    child: Center(
                      child: Text(
                        letter,
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF333333),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 32),

          ElevatedButton(
            onPressed: _removeLastLetter,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF44336),
            ),
            child: const Text('删除最后一个字母'),
          ),

          const SizedBox(height: 32),

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
                    _isCorrect ? '拼写正确！' : '拼写错误',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: _isCorrect ? const Color(0xFF2E7D32) : const Color(0xFFC62828),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  if (!_isCorrect)
                    Text(
                      '正确答案是 $_targetWord',
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

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _prevLevel,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF81C784),
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
    );
  }
}
