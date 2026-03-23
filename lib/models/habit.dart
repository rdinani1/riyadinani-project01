class Habit {
  final int? id;
  final String title;
  final String description;
  final String category;
  final String createdAt;
  final bool isCompleted;

  Habit({
    this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.createdAt,
    this.isCompleted = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'created_at': createdAt,
      'is_completed': isCompleted ? 1 : 0,
    };
  }

  factory Habit.fromMap(Map<String, dynamic> map) {
    return Habit(
      id: map['id'],
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      createdAt: map['created_at'] ?? '',
      isCompleted: map['is_completed'] == 1,
    );
  }
}