import 'package:flutter_tagging_plus/flutter_tagging_plus.dart';

class TagModel extends Taggable {
  final int? id;
  final String label;
  final String? createdAt;
  final String? updatedAt;

 const TagModel({
    this.id,
    required this.label,
    this.createdAt,
    this.updatedAt,
  });

  factory TagModel.fromJson(Map<String, dynamic> json) {
    return TagModel(
      id: json['id'] != null ? int.parse(json['id'].toString()) : null,
      label: json['label'].toString(),
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
    );
  }
  
  String toJson() => '''  {
    "label": $label,\n
  }''';

  
  @override
  List<Object> get props => [label];

}
