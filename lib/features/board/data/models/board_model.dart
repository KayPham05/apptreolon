class BoardModel {
  final String id;
  final String title;

  BoardModel({required this.id, required this.title});

  factory BoardModel.fromJson(Map<String, dynamic> json) {
    return BoardModel(
      id: json['id'],
      title: json['title'],
    );
  }
}
