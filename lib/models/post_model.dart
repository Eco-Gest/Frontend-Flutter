import 'package:ecogest_front/data/ecogest_api_data_source.dart';
import 'package:ecogest_front/models/category_model.dart';
import 'package:ecogest_front/models/comment_model.dart';
import 'package:ecogest_front/models/like_model.dart';
import 'package:ecogest_front/models/tag_model.dart';
import 'package:ecogest_front/models/user_model.dart';
import 'package:ecogest_front/models/user_post_participation_model.dart';

class PostModel {
  final int? id;
  final int? categoryId;
  final int? authorId;
  final List<TagModel>? tags;
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
  final UserModel? user;
  final List<UserPostParticipationModel>? userPostParticipation;
  final CategoryModel? category;
  final List<LikeModel>? likes;
  final List<CommentModel?>? comments;

  const PostModel({
    this.id,
    required this.categoryId,
    this.authorId,
    this.tags,
    this.title,
    this.description,
    this.image,
    this.position,
    required this.type,
    required this.level,
    this.startDate,
    this.endDate,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.userPostParticipation,
    this.category,
    this.likes,
    this.comments,
  });

  PostModel copyWith(categoryId, authorId, type, level, startDate, endDate) {
    return PostModel(
        categoryId: categoryId ?? this.categoryId,
        type: type ?? this.type,
        level: level ?? this.level,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate);
  }

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] != null ? int.parse(json['id'].toString()) : null,
      categoryId: json['category_id'] != null
          ? int.parse(json['category_id'].toString())
          : null,
      authorId: json['author_id'] != null
          ? int.parse(json['author_id'].toString())
          : null,
      tags: json['tags'] != null
          ? List.from(json['tags']).map((e) => TagModel.fromJson(e)).toList()
          : null,
      title: json['title']?.toString(),
      description: json['description']?.toString(),
      image: json['image'] != null
          ? Uri.parse(EcoGestApiDataSource.baseUrl + '/image/' + json['image'])
              .toString()
          : null,
      position: json['position']?.toString(),
      type: json['type']?.toString() ?? "",
      level: json['level']?.toString() ?? "",
      startDate: json['start_date']?.toString(),
      endDate: json['end_date']?.toString(),
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
      user: json['user'] != null
          ? UserModel.fromJson(json['user'] as Map<String, Object?>)
          : null,
      userPostParticipation: json['user_post_participation'] != null
          ? userPostParticipationList(json['user_post_participation'])
          : null,
      likes: json['like'] != null ? listLike(json['like']) : null,
      category: json['category'] != null
          ? CategoryModel.fromJson(json['category'] as Map<String, Object?>)
          : null,
      comments: json['comment'] != null ? commentList(json['comment']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category_id': categoryId,
      'author_id': authorId,
      'tags': tags?.map((tag) => tag.toJson()).toList(),
      'title': title,
      'description': description,
      'image': image,
      'position': position,
      'type': type,
      'level': level,
      'start_date': startDate == null
          ? null
          : DateTime.parse(startDate!).toIso8601String(),
      'end_date':
          endDate == null ? null : DateTime.parse(endDate!).toIso8601String(),
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  static List<CommentModel?>? commentList(List<dynamic> responseList) {
    return responseList.map((comment) {
      return CommentModel.fromJson(comment as Map<String, dynamic>);
    }).toList();
  }

  static List<LikeModel>? listLike(List<dynamic> responseList) {
    return responseList.map((like) {
      return LikeModel.fromJson(like as Map<String, dynamic>);
    }).toList();
  }

  static List<UserPostParticipationModel>? userPostParticipationList(
      List<dynamic> responseList) {
    return responseList.map((participation) {
      return UserPostParticipationModel.fromJson(
          participation as Map<String, dynamic>);
    }).toList();
  }
}

enum PostType {
  action(displayName: 'Geste'),
  challenge(displayName: 'Défi');

  // "Attribut" de l'enum, pour que chaque type puisse avoir un nom d'affichage
  final String displayName;

  // Sorte de "Constructeur" de l'enum, ne sera jamais utilisé directement,
  // mais permet de définir l'attribut displayName
  const PostType({required this.displayName});

  // "Factory" utile pour récupérer un type d'ingrédient depuis sa valeur en String
  factory PostType.fromValue(String value) =>
      PostType.values.firstWhere((type) => type.name == value,
          orElse: () => throw Exception('Unkown type value : $value'));
}

enum PostLevel {
  easy(displayName: 'Facile'),
  medium(displayName: 'Moyen'),
  hard(displayName: 'Difficile');

  // "Attribut" de l'enum, pour que chaque Level puisse avoir un nom d'affichage
  final String displayName;

  // Sorte de "Constructeur" de l'enum, ne sera jamais utilisé directement,
  // mais permet de définir l'attribut displayName
  const PostLevel({required this.displayName});

  // "Factory" utile pour récupérer un Level d'ingrédient depuis sa valeur en String
  factory PostLevel.fromValue(String value) =>
      PostLevel.values.firstWhere((level) => level.name == value,
          orElse: () => throw Exception('Unkown level value : $value'));
}
