import 'package:ecogest_front/models/post_model.dart';
import 'package:ecogest_front/models/user_model.dart';

class NotificationModel {
  final String? title;
  final UserModel? user;
  final PostModel? post;

  const NotificationModel({
    required this.title,
    this.user,
    this.post,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
        title: json['title']?.toString(),
        user: json['user'] != null
            ? UserModel.fromJson(json['user'] as Map<String, Object?>)
            : null,
        post: json['post'] != null
            ? PostModel.fromJson(json['post'] as Map<String, Object?>)
            : null);
  }
}
