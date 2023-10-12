class CategoryModel {
  final int? id;
  final String? title;
  final String? image;
  final String? createdAt;
  final String? updatedAt;

 const CategoryModel({
    required this.id,
    this.title,
    this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] != null ? int.parse(json['id'].toString()) : null,
      title: json['title']?.toString(),
      image: json['image']?.toString(),
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
    );
  }
}
