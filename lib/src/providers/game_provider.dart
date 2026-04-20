import 'package:flutter/material.dart';
import 'package:autism_work_integration_tool/src/services/service_locator.dart';

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
      
      // 加载游戏分数
      final gameScores = storage.getString('gameScores');
      if (gameScores != null && gameScores.isNotEmpty) {
        try {
          _gameScores = _parseMapString(gameScores);
        } catch (e) {
          // 解析失败时使用空映射
          _gameScores = {};
        }
      }
      
      // 加载游戏等级
      final gameLevels = storage.getString('gameLevels');
      if (gameLevels != null && gameLevels.isNotEmpty) {
        try {
          _gameLevels = _parseMapString(gameLevels);
        } catch (e) {
          // 解析失败时使用空映射
          _gameLevels = {};
        }
      }
    } catch (e) {
      // 处理任何异常，确保应用不会崩溃
      _totalGamesPlayed = 0;
      _totalScore = 0;
      _level = 1;
      _gameScores = {};
      _gameLevels = {};
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
      await storage.saveString('gameScores', _gameScores.toString());
      await storage.saveString('gameLevels', _gameLevels.toString());
    } catch (e) {
      // 处理保存失败的情况，确保应用不会崩溃
    }
  }

  Map<String, int> _parseMapString(String mapString) {
    final Map<String, int> result = {};
    try {
      // 移除首尾的大括号
      final cleanString = mapString.trim().substring(1, mapString.length - 1).trim();
      if (cleanString.isEmpty) {
        return result;
      }
      
      // 分割键值对
      final entries = cleanString.split(', ');
      for (final entry in entries) {
        final parts = entry.split(': ');
        if (parts.length == 2) {
          final key = parts[0].replaceAll('"', '').trim();
          final valueStr = parts[1].trim();
          final value = int.tryParse(valueStr);
          if (value != null && key.isNotEmpty) {
            result[key] = value;
          }
        }
      }
    } catch (e) {
      // 解析失败时返回空映射
    }
    return result;
  }

  void updateGameScore(String gameName, int score) {
    _totalGamesPlayed++;
    _totalScore += score;
    _gameScores[gameName] = (_gameScores[gameName] ?? 0) + score;
    
    // 计算等级
    _calculateLevel();
    
    _saveData();
    notifyListeners();
  }

  void updateGameLevel(String gameName, int level) {
    if (_gameLevels[gameName] == null || level > _gameLevels[gameName]!) {
      _gameLevels[gameName] = level;
      _saveData();
      notifyListeners();
    }
  }

  void _calculateLevel() {
    // 每1000分升一级
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
  }
}
