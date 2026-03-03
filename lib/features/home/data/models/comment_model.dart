class CommentModel {
  final String commentId;
  final String articleUrl;
  final String userId;
  final String text;
  final DateTime? createdAt;

  CommentModel({
    required this.commentId,
    required this.articleUrl,
    required this.userId,
    required this.text,
    required this.createdAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      commentId: json['c_id'],
      articleUrl: json['url'],
      userId: json['u_id'],
      text: json['text'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'c_id': commentId,
      'url': articleUrl,
      'u_id': userId,
      'text': text,
      'created_at':
          createdAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
    };
  }
}
