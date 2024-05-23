import 'package:ecogest_front/data/ecogest_api_data_source.dart';
import 'package:ecogest_front/models/users_relation_model.dart';
import 'package:ecogest_front/models/user_model.dart';
import 'package:ecogest_front/services/authentication_service.dart';

class UsersRelationService {
  static Future<void> subscribe(int userId) async {
    final String? token = await AuthenticationService.getToken();

    await EcoGestApiDataSource.post('/users/$userId/subscribe', {},
        token: token);
  }

  static Future<void> unSubscribe(int userId) async {
    final String? token = await AuthenticationService.getToken();

    await EcoGestApiDataSource.delete('/users/$userId/unsubscribe', {},
        token: token);
  }

  static Future<void> cancel(int userId) async {
    final String? token = await AuthenticationService.getToken();

    await EcoGestApiDataSource.delete(
        '/users/$userId/cancel-subscription-request', {},
        token: token);
  }

  static Future<UsersRelationModel> approve(int userId) async {
    final String? token = await AuthenticationService.getToken();

    final response = await EcoGestApiDataSource.post(
        '/users/$userId/accept-subscription-request', {},
        token: token);

    final subscription = UsersRelationModel.fromJson(response);
    return subscription;
  }

  static Future<void> decline(int userId) async {
    final String? token = await AuthenticationService.getToken();

    await EcoGestApiDataSource.delete(
        '/users/$userId/decline-subscription-request', {},
        token: token);
  }

  static Future<void> removeFollower(int userId) async {
    final String? token = await AuthenticationService.getToken();

    await EcoGestApiDataSource.delete('/remove-follower/$userId', {},
        token: token);
  }

  static Future<void> blockUser(int userId) async {
    final String? token = await AuthenticationService.getToken();

    await EcoGestApiDataSource.post('/users/$userId/block', {}, token: token);
  }

  static Future<void> unBlockUser(int userId) async {
    final String? token = await AuthenticationService.getToken();

    await EcoGestApiDataSource.delete('/users/$userId/unblock', {},
        token: token);
  }

  static bool? isFollowing(UserModel userAuthenticated, UserModel user) {
    UsersRelationModel? userFollowing = userAuthenticated.following!
        .where((subscription) => subscription!.followingId == user.id!)
        .firstOrNull;
    if (userFollowing == null) {
      return null;
    }

    return userFollowing.status == "approved";
  }

  static bool? isFollowed(UserModel userAuthenticated, UserModel user) {
    UsersRelationModel? userFollower = userAuthenticated.followers!
        .where((subscription) => subscription!.followerId == user.id!)
        .firstOrNull;
    if (userFollower == null) {
      return null;
    }
    return userFollower.status == "approved";
  }

  static bool? isBlocked(UserModel userAuthenticated, UserModel user) {
    UsersRelationModel? usersRelationModel = userAuthenticated.following!
        .where((subscription) => subscription!.followingId == user.id!)
        .firstOrNull;
    if (usersRelationModel == null) {
      return null;
    }
    return usersRelationModel.status == "blocked";
  }
}
