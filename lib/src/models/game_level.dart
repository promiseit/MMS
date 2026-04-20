class GameLevel {
  final int id;
  final int difficulty;
  final String title;
  final String description;
  final List<String> items;

  GameLevel({
    required this.id,
    required this.difficulty,
    required this.title,
    required this.description,
    required this.items,
  });
}
