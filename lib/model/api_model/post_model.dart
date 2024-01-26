class PostModel {
  int id;
  String title;

  PostModel({ required this.id, required this.title});

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      title: json['title'],
    );
  }
}

