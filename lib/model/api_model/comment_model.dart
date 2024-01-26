class CommentModel {
  int id;
  String body;
  int postId;

  CommentModel({required this.id, required this.body, required this.postId});

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'],
      body: json['body'],
      postId: json['postId'],
    );
  }
}
