import 'package:ecogest_front/models/user_model.dart';

class UsersRelationModel {
  final int? id;
  final int? followerId;
  final UserModel? follower;
  final int? followingId;
  final UserModel? following;
  final String? status;
  final String? createdAt;
  final String? updatedAt;

  const UsersRelationModel({
    this.id,
    this.followerId,
    this.follower,
    this.followingId,
    this.following,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory UsersRelationModel.fromJson(Map<String, dynamic> json) {
    return UsersRelationModel(
      id: json['id'] != null ? int.parse(json['id'].toString()) : null,
      followerId: json['follower_id'] != null
          ? int.parse(json['follower_id'].toString())
          : null,
      follower: json['follower'] != null
          ? UserModel.fromJson(json['follower'] as Map<String, Object?>)
          : null,
      followingId: json['following_id'] != null
          ? int.parse(json['following_id'].toString())
          : null,
      following: json['following'] != null
          ? UserModel.fromJson(json['following'] as Map<String, Object?>)
          : null,
      status: json['status']?.toString(),
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
    );
  }
}
