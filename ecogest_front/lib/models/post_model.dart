class PostModel {
  final int? id;
  final int? categoryId;
  final int? authorId;
  final String? tag;
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

  const PostModel({
    required this.id,
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
    required this.createdAt,
    required this.updatedAt,
  });

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
      type: json['type']?.toString(),
      level: json['level']?.toString(),
      startDate: json['start_date']?.toString(),
      endDate: json['end_date']?.toString(),
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
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
    };
  }
}
