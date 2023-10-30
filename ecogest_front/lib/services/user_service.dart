import 'dart:async';

import 'package:ecogest_front/data/ecogest_api_data_source.dart';
import 'package:ecogest_front/models/user_model.dart';
import 'package:ecogest_front/services/authentication_service.dart';
import 'package:flutter/material.dart';

class UserService {
  static final controller = StreamController<UserModel?>();

  static Future<UserModel> getCurrentUser() async {
    final String? token = await AuthenticationService.getToken();

    var responseMap = await EcoGestApiDataSource.get('/me', token: token);

    final user = UserModel.fromJson(responseMap);
    controller.add(user);
    return user;
  }

  static Future<UserModel> updateUserAccount(UserModel user) async {
    final String? token = await AuthenticationService.getToken();

    final body = user.toJson();

    var responseMap =
        await EcoGestApiDataSource.patch('/me', body, token: token);

    return UserModel.fromJson(responseMap);
  }

  static Future<UserModel> getUser(int userId) async {
    final String? token = await AuthenticationService.getToken();

    var responseMap =
        await EcoGestApiDataSource.get('/users/$userId', token: token);

    return UserModel.fromJson(responseMap);
  }

  static Stream<UserModel?> get getStatus {
    return controller.stream;
  }
}
