class PointCategoryModel {
  final int? id;
  final int? user_id;
  final int? category_id;
  final int? total_points;

 const PointCategoryModel({
    required this.id,
    required this.user_id,
    required this.category_id,
    required this.total_points,
  });

  factory PointCategoryModel.fromJson(Map<String, dynamic> json) {
    return PointCategoryModel(
      id: json['id'] != null ? int.parse(json['id'].toString()) : null,
      user_id: json['user_id'] != null ? int.parse(json['user_id'].toString()) : null,
      category_id: json['category_id'] != null ? int.parse(json['category_id'].toString()) : null,
      total_points: json['total_points'] != null ? int.parse(json['total_points'].toString()) : null,
    );
  }
}