import 'package:ecogest_front/models/category_model.dart';
import 'package:ecogest_front/models/user_model.dart';

class PostModel {
  final int? id;
  final int? categoryId;
  final int? authorId;
  final String? tag;
  final String? title;
  final String? description;
  final String? image;
  final String? position;
  final PostType? type;
  final PostLevel? level;
  final String? startDate;
  final String? endDate;
  final String? createdAt;
  final String? updatedAt;
  final UserModel? user;
  final List? userPostParticipation;
  final CategoryModel? category;
  final List? likes;
  final List? comments;

  const PostModel({
    this.id,
    required this.categoryId,
    required this.authorId,
    this.tag,
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


  PostModel copyWith(categoryId, authorId, type, level, startDate, endDate){
    return PostModel(
        categoryId: categoryId ?? this.categoryId,
        authorId: authorId ?? this.authorId,
        type: type ?? this.type,
        level: level ?? this.level,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate
    );
  }

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] != null ? int.parse(json['id'].toString()) : null,
      categoryId: json['category_id'] != null ? int.parse(json['category_id'].toString()) : null,
      authorId: json['author_id'] != null ? int.parse(json['author_id'].toString()) : null,
      tag: json['tag']?.toString(),
      title: json['title']?.toString(),
      description: json['description']?.toString(),
      image: json['image']?.toString(),
      position: json['position']?.toString(),
      type: json['type']?.PostType.fromValue(),
      level: json['level']?.LevelType.fromValue(),
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
      'tag': tag,
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