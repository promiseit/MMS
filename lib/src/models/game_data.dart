class WordItem {
  final String word;
  final String hint;

  WordItem({
    required this.word,
    required this.hint,
  });

  factory WordItem.fromJson(Map<String, dynamic> json) {
    return WordItem(
      word: json['word'] as String,
      hint: json['hint'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'word': word,
      'hint': hint,
    };
  }
}

class GameLevelData {
  final int difficulty;
  final String title;
  final String description;
  final List<WordItem> words;

  GameLevelData({
    required this.difficulty,
    required this.title,
    required this.description,
    required this.words,
  });

  factory GameLevelData.fromJson(Map<String, dynamic> json) {
    return GameLevelData(
      difficulty: json['difficulty'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      words: (json['words'] as List<dynamic>)
          .map((e) => WordItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'difficulty': difficulty,
      'title': title,
      'description': description,
      'words': words.map((e) => e.toJson()).toList(),
    };
  }
}
