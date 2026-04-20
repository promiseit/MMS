import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:autism_work_integration_tool/src/models/game_data.dart';
import 'package:autism_work_integration_tool/src/services/logger_service.dart';

class DataService {
  static Future<List<GameLevelData>> loadEnglishSpellingWords() async {
    try {
      final String jsonString = await rootBundle.loadString('assets/data/english_spelling_words.json');
      final List<dynamic> jsonList = jsonDecode(jsonString) as List<dynamic>;
      return jsonList.map((json) => GameLevelData.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e, stackTrace) {
      LoggerService.error('加载英语拼写单词数据失败', e, stackTrace);
      return [];
    }
  }
}
