import 'dart:async';

import 'package:ecogest_front/data/ecogest_api_data_source.dart';
import 'package:ecogest_front/models/user_model.dart';
import 'package:ecogest_front/models/points_category_model.dart';
import 'package:ecogest_front/services/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecogest_front/services/notifications/notifications_service.dart';
import 'package:pusher_beams/pusher_beams.dart';

class UserService {
  static final NotificationsService notificationsService =
      NotificationsService();

  static Future<UserModel> getCurrentUser() async {
    final String? token = await AuthenticationService.getToken();

    var responseMap = await EcoGestApiDataSource.get('/me', token: token);

    final user = UserModel.fromJson(responseMap);

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userId', '${user.id}');

    await PusherBeams.instance.addDeviceInterest('user-${user.id}');
    return user;
  }

  static Future<UserModel> updateUserAccount(UserModel user) async {
    final String? token = await AuthenticationService.getToken();

    final body = user.toJson();

    final result = await EcoGestApiDataSource.patch('/me', body, token: token);

    if (user.image != null && user.image!.isNotEmpty) {
      await EcoGestApiDataSource.addImage(
          '/users/${result['id']}/uploadImage', user.image!,
          token: token);
    }
    return user;
  }

  static Future<UserModel> getUser(int userId) async {
    final String? token = await AuthenticationService.getToken();

    var responseMap =
        await EcoGestApiDataSource.get('/users/$userId', token: token);

    return UserModel.fromJson(responseMap);
  }

  static Future<List<PointCategoryModel>>
      getCurrentUserCategoriesPoints() async {
    final UserModel currentUser = await UserService.getCurrentUser();

    // Check if the user model is not null and get the user ID.
    final int? userId = currentUser.id;
    if (userId == null) {
      throw Exception('User id does not exist');
    }

    // Get the authentication token.
    final String? token = await AuthenticationService.getToken();

    // Make the API request using the user ID.
    final List<dynamic> responseMap = await EcoGestApiDataSource.get(
        '/users/$userId/categories-points',
        token: token);

    // Map the response to a list
    final List<PointCategoryModel> pointsByCategory = responseMap.map((points) {
      return PointCategoryModel.fromJson(points);
    }).toList();

    // 6. Return the list
    return pointsByCategory;
  }

  static Future<void> submitReport(int userId, String result) async {
    try {
      final String? token = await AuthenticationService.getToken();

      final Map<String, dynamic> requestBody = {
        'ID': userId,
        'title': 'profil',
        'authorID': userId,
        'result': result,
        'content': 'Profil de l\'utilisateur signalé',
      };
      await EcoGestApiDataSource.post('/submit-report', requestBody,
          token: token);
    } catch (error) {
      throw Exception('Échec du signalement');
    }
  }

  static Future<void> changePassword(
      {required String oldPassword,
      required String password,
      required String passwordRepeated}) async {
    try {
      final String? token = await AuthenticationService.getToken();
      final Map<String, dynamic> requestBody = {
        'old_password': oldPassword,
        'new_password': password,
        'confirm_password': passwordRepeated,
      };

      await EcoGestApiDataSource.post('/change-password', requestBody,
          token: token);
    } catch (error) {
      throw Exception('Échec du changement de mot de passe');
    }
  }
}
