import 'package:ecogest_front/data/ecogest_api_data_source.dart';
import 'package:ecogest_front/models/user_model.dart';
import 'package:ecogest_front/models/points_category_model.dart';
import 'package:ecogest_front/services/authentication_service.dart';
import 'package:flutter/material.dart';

class UserService {
  static Future<UserModel> getCurrentUser() async {
    final String? token = await AuthenticationService.getToken();

    var responseMap = await EcoGestApiDataSource.get('/me', token: token);

    return UserModel.fromJson(responseMap);
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

    static Future<List<PointCategoryModel>> getCurrentUserCategoriesPoints() async {
      final UserModel? currentUser = await UserService.getCurrentUser();
      
      // Check if the user model is not null and get the user ID.
      final int? userId = currentUser?.id;
      if (userId == null) {
          throw Exception('User id does not exist');
      }

      // Get the authentication token.
      final String? token = await AuthenticationService.getToken();
      
      // Make the API request using the user ID.
      final List<dynamic> responseMap = await EcoGestApiDataSource.get('/users/$userId/categories-points', token: token);

      // Map the response to a list 
      final List<PointCategoryModel> pointsByCategory = responseMap.map((points) {
        return PointCategoryModel.fromJson(points);
      }).toList();

      // 6. Return the list 
      return pointsByCategory;
  }
}
