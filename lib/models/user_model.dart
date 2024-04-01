import 'package:ecogest_front/data/ecogest_api_data_source.dart';
import 'package:ecogest_front/models/subscription_model.dart';
import 'package:ecogest_front/models/user_post_participation_model.dart';

class UserModel {
  final int? id;
  final String? email;
  final String? username;
  final int? badgeId;
  final String? badgeTitle;
  final int? badgePoints;
  final int? totalPoints;
  final String? image;
  final String? birthdate;
  final String? biography;
  final String? position;
  final bool? isPrivate;
  final String? createdAt;
  final String? updatedAt;
  final String? postParticipationCount;
  final List<SubscriptionModel?>? followers;
  final List<SubscriptionModel?>? following;

  const UserModel({
    this.id,
    this.email,
    this.username,
    this.badgeId,
    this.badgeTitle,
    this.badgePoints,
    this.totalPoints,
    this.image,
    this.birthdate,
    this.biography,
    this.position,
    this.isPrivate,
    this.createdAt,
    this.updatedAt,
    this.postParticipationCount,
    this.followers,
    this.following,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] != null ? int.parse(json['id'].toString()) : null,
        email: json['email']?.toString(),
        username: json['username']?.toString(),
        badgeId: json['badge_id'] != null
            ? int.parse(json['badge_id'].toString())
            : null,
        badgeTitle: json['badge']?['title']?.toString(),
        badgePoints: json['badge'] != null
            ? int.parse(json['badge']['point'].toString())
            : null,
        totalPoints: json['total_point'] != null
            ? int.parse(json['total_point'].toString())
            : null,
        image: json['image'] != null
            ? Uri.parse(
                    EcoGestApiDataSource.baseUrl + '/image/' + json['image'])
                .toString()
            : null,
        birthdate: json['birthdate']?.toString(),
        biography: json['biography']?.toString(),
        position: json['position']?.toString(),
        isPrivate: json['is_private']?.toString() == "true" ? true : false,
        createdAt: json['created_at']?.toString(),
        updatedAt: json['updated_at']?.toString(),
        postParticipationCount: json['user_post_participation'] != null
            ? userPostParticipationList(json['user_post_participation'])
                ?.length
                .toString()
            : null,
        followers: json['follower'] != null
            ? subscriptionList(json['follower'])
            : null,
        following: json['following'] != null
            ? subscriptionList(json['following'])
            : null,
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["username"] = username;
    data["image"] = image;
    data["birthdate"] = birthdate;
    data["biography"] = biography;
    data["position"] = position;
    data["is_private"] = isPrivate;
    return data;
  }

  static List<SubscriptionModel?>? subscriptionList(
      List<dynamic> responseList) {
    return responseList.map((follower) {
      return SubscriptionModel.fromJson(follower as Map<String, dynamic>);
    }).toList();
  }

  static List<UserPostParticipationModel>? userPostParticipationList(
      List<dynamic> responseList) {
    return responseList.map((participation) {
      return UserPostParticipationModel.fromJson(
          participation as Map<String, dynamic>);
    }).toList();
  }
}
