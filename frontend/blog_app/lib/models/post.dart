class Post {
  final int id;
  final String title;
  final String content;
  final DateTime createdAt;

  Post({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      content: json['content'] as String? ?? '',
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt'] as String) : DateTime.now(),
    );
  }
}