class CategoryModel {
  final int? id;
  final String? title;
  final String? image;
  final String? createdAt;
  final String? updatedAt;

  const CategoryModel({
    this.id,
    required this.title,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json['id'] != null ? int.parse(json['id'].toString()) : null,
        title: json['title']?.toString(),
        image: json['image']?.toString(),
        createdAt: json['create_at']?.toString(),
        updatedAt: json['updated_at']?.toString(),
      );
}
