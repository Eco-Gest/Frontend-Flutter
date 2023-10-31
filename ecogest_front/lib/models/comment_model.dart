import 'package:ecogest_front/models/user_model.dart';

class CommentModel {
  final int? id;
  final int? postId;
  final int? authorId;
  final String? content;
  final UserModel? author; 
  final String? createdAt;
  final String? updatedAt;

 const CommentModel({
    this.id,
    required this.postId,
    this.authorId,
    required this.content,
    this.author,
    this.createdAt,
    this.updatedAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
      id: json['id'] != null ? int.parse(json['id'].toString()) : null,
      postId: json['post_id'] != null ? int.parse(json['post_id'].toString()) : null,
      authorId: json['author_id'] != null ? int.parse(json['author_id'].toString()) : null,
      content: json['content']?.toString(),
      author: UserModel.fromJson(json['users'] as Map<String, Object?>),
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
    );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'post_id': postId,
      'author_id': authorId,
      'content': content,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
