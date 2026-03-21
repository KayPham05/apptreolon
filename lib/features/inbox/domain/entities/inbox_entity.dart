// Entity mapped from C# UserInboxCard.cs + Card.cs
class InboxEntity {
  final String id;
  final String cardTitle;
  final String? description;
  final bool isCompleted;
  final DateTime addedAt;

  const InboxEntity({
    required this.id,
    required this.cardTitle,
    this.description,
    required this.isCompleted,
    required this.addedAt,
  });

  InboxEntity copyWith({bool? isCompleted}) {
    return InboxEntity(
      id: id,
      cardTitle: cardTitle,
      description: description,
      isCompleted: isCompleted ?? this.isCompleted,
      addedAt: addedAt,
    );
  }
}
