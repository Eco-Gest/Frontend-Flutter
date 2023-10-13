class TrophyModel {
  final int? id;
  final int? user_id;
  final int? category_id;
  final int? current_point;

 const TrophyModel({
    required this.id,
    required this.user_id,
    required this.category_id,
    required this.current_point,
  });

  factory TrophyModel.fromJson(Map<String, dynamic> json) {
    return TrophyModel(
      id: json['id'] != null ? int.parse(json['id'].toString()) : null,
      user_id: json['user_id'] != null ? int.parse(json['user_id'].toString()) : null,
      category_id: json['category_id'] != null ? int.parse(json['category_id'].toString()) : null,
      current_point: json['current_point'] != null ? int.parse(json['current_point'].toString()) : null,
    );
  }
}