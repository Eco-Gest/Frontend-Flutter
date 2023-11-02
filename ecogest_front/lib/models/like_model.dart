class LikeModel {
  LikeModel({
    required this.id,
    required this.postId,
    required this.userId,
     this.createdAt,
     this.updatedAt,
  });
  late final int id;
  late final int postId;
  late final int userId;
  late final String? createdAt;
  late final String? updatedAt;
  
  LikeModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    postId = json['post_id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    return {
    'id': id,
    'post_id': postId,
    'user_id': userId,
    'created_at': createdAt,
    'updated_at': updatedAt,
    };
  }
}