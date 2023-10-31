class TagModel {
  final int? id;
  final String? label;
  final String? createdAt;
  final String? updatedAt;

 const TagModel({
    required this.id,
    this.label,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TagModel.fromJson(Map<String, dynamic> json) {
    return TagModel(
      id: json['id'] != null ? int.parse(json['id'].toString()) : null,
      label: json['label']?.toString(),
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'label': label,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

}
