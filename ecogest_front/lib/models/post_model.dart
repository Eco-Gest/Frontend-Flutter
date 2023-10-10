import 'package:ecogest_front/models/category_model.dart';
import 'package:ecogest_front/models/user_model.dart';
import 'package:ecogest_front/models/user_post_participation_model.dart';

class PostModel {
  final int? id;
  final int? categoryId;
  final int? authorId;
  final String? tags;
  final String? title;
  final String? description;
  final String? image;
  final String? position;
  final String? type;
  final String? level;
  final String? startDate;
  final String? endDate;
  final String? createdAt;
  final String? updatedAt;
  final UserModel user;
  final List? userPostParticipation;
  final CategoryModel category;
  final List? likes;
  final List? comments;

  const PostModel({
    required this.id,
    required this.categoryId,
    required this.authorId,
    this.tags,
    this.title,
    this.description,
    this.image,
    this.position,
    required this.type,
    required this.level,
    this.startDate,
    this.endDate,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    this.userPostParticipation,
    required this.category,
    this.likes,
    this.comments,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] != null ? int.parse(json['id'].toString()) : null,
      categoryId: json['category_id'] != null ? int.parse(json['category_id'].toString()) : null,
      authorId: json['author_id'] != null ? int.parse(json['author_id'].toString()) : null,
      tags: json['tag'],
      title: json['title']?.toString(),
      description: json['description']?.toString(),
      image: json['image']?.toString(),
      position: json['position']?.toString(),
      type: json['type']?.toString(),
      level: json['level']?.toString(),
      startDate: json['start_date']?.toString(),
      endDate: json['end_date']?.toString(),
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
      user: UserModel.fromJson(json['user'] as Map<String, Object?>),
      userPostParticipation: json['user_post_participation'],
      category: CategoryModel.fromJson(json['category'] as Map<String, Object?>),
      likes: json['like'],
      comments: json['comment'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category_id': categoryId,
      'author_id': authorId,
      'tag': tags,
      'title': title,
      'description': description,
      'image': image,
      'position': position,
      'type': type,
      'level': level,
      'start_date': startDate,
      'end_date': endDate,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'user': user,
      'user_post_participation': userPostParticipation,
      'category': category,
      'like': likes,
      'comment': comments,
    };
  }
}
