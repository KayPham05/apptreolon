// Entity mapped from C# Card.cs
class CardEntity {
  final String id;
  final String title;
  final String? description;
  final DateTime? dueDate;
  final int position;
  final String status;
  final String? listId;

  const CardEntity({
    required this.id,
    required this.title,
    this.description,
    this.dueDate,
    required this.position,
    this.status = 'To Do',
    this.listId,
  });
}
