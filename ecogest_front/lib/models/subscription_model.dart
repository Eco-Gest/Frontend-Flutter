class SubscriptionModel {
  final int? id;
  final int? followerId;
  final int? followingId;
  final String? status;
  final String? createdAt;
  final String? updatedAt;

  const SubscriptionModel({
    required this.id,
    this.followerId,
    this.followingId,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionModel(
      id: json['id'] != null ? int.parse(json['id'].toString()) : null,
      followerId: json['follower_id'] != null
          ? int.parse(json['follower_id'].toString())
          : null,
      followingId: json['following_id'] != null
          ? int.parse(json['following_id'].toString())
          : null,
      status: json['status']?.toString(),
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
    );
  }
}
