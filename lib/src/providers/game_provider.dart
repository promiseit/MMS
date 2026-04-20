import 'package:flutter/material.dart';
import 'package:autism_work_integration_tool/src/services/service_locator.dart';
import 'package:autism_work_integration_tool/src/services/json_service.dart';
import 'package:autism_work_integration_tool/src/services/logger_service.dart';

class GameProvider extends ChangeNotifier {
  int _totalGamesPlayed = 0;
  int _totalScore = 0;
  int _level = 1;
  Map<String, int> _gameScores = {};
  Map<String, int> _gameLevels = {};

  int get totalGamesPlayed => _totalGamesPlayed;
  int get totalScore => _totalScore;
  int get level => _level;
  Map<String, int> get gameScores => _gameScores;
  Map<String, int> get gameLevels => _gameLevels;

  GameProvider() {
    _init();
  }

  Future<void> _init() async {
    await _loadData();
  }

  Future<void> _loadData() async {
    try {
      final storage = serviceLocator.storageService;
      _totalGamesPlayed = storage.getInt('totalGamesPlayed', 0);
      _totalScore = storage.getInt('totalScore', 0);
      _level = storage.getInt('level', 1);
      
      final gameScoresJson = storage.getString('gameScores');
      if (gameScoresJson != null && gameScoresJson.isNotEmpty) {
        _gameScores = JsonService.decodeMap(gameScoresJson);
      }
      
      final gameLevelsJson = storage.getString('gameLevels');
      if (gameLevelsJson != null && gameLevelsJson.isNotEmpty) {
        _gameLevels = JsonService.decodeMap(gameLevelsJson);
      }
      
      LoggerService.debug('游戏数据加载成功');
    } catch (e, stackTrace) {
      _totalGamesPlayed = 0;
      _totalScore = 0;
      _level = 1;
      _gameScores = {};
      _gameLevels = {};
      LoggerService.error('加载游戏数据失败', e, stackTrace);
    } finally {
      notifyListeners();
    }
  }

  Future<void> _saveData() async {
    try {
      final storage = serviceLocator.storageService;
      await storage.saveInt('totalGamesPlayed', _totalGamesPlayed);
      await storage.saveInt('totalScore', _totalScore);
      await storage.saveInt('level', _level);
      await storage.saveString('gameScores', JsonService.encodeMap(_gameScores));
      await storage.saveString('gameLevels', JsonService.encodeMap(_gameLevels));
      LoggerService.debug('游戏数据保存成功');
    } catch (e, stackTrace) {
      LoggerService.error('保存游戏数据失败', e, stackTrace);
    }
  }

  void updateGameScore(String gameName, int score) {
    _totalGamesPlayed++;
    _totalScore += score;
    _gameScores[gameName] = (_gameScores[gameName] ?? 0) + score;
    
    _calculateLevel();
    
    _saveData();
    notifyListeners();
    LoggerService.debug('更新游戏分数: $gameName +$score');
  }

  void updateGameLevel(String gameName, int level) {
    if (_gameLevels[gameName] == null || level > _gameLevels[gameName]!) {
      _gameLevels[gameName] = level;
      _saveData();
      notifyListeners();
      LoggerService.debug('更新游戏等级: $gameName -> $level');
    }
  }

  void _calculateLevel() {
    _level = (_totalScore ~/ 1000) + 1;
  }

  Future<void> resetProgress() async {
    _totalGamesPlayed = 0;
    _totalScore = 0;
    _level = 1;
    _gameScores = {};
    _gameLevels = {};
    await _saveData();
    notifyListeners();
    LoggerService.info('游戏进度已重置');
  }
}
