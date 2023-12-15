import 'package:ecogest_front/data/ecogest_api_data_source.dart';
import 'package:ecogest_front/models/subscription_model.dart';
import 'package:ecogest_front/models/user_model.dart';
import 'package:ecogest_front/services/authentication_service.dart';

class SubscriptionService {
  static Future<SubscriptionModel> subscribe(int userId) async {
    final String? token = await AuthenticationService.getToken();

    final response = await EcoGestApiDataSource.post(
        '/users/$userId/subscribe', {},
        token: token);

    final subscription = SubscriptionModel.fromJson(response);
    return subscription;
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

  static Future<SubscriptionModel> approve(int userId) async {
    final String? token = await AuthenticationService.getToken();

    final response = await EcoGestApiDataSource.post(
        '/users/$userId/accept-subscription-request', {},
        token: token);

    final subscription = SubscriptionModel.fromJson(response);
    return subscription;
  }

  static Future<void> decline(int userId) async {
    final String? token = await AuthenticationService.getToken();

    await EcoGestApiDataSource.delete(
        '/users/$userId/decline-subscription-request', {},
        token: token);
  }

  static bool? isFollowing(UserModel userAuthenticated, UserModel user) {
    SubscriptionModel? userFollowing = userAuthenticated!.following!
        .where((subscription) => subscription!.followingId == user.id!)
        .firstOrNull;
    if (userFollowing == null) {
      return null;
    }

    return userFollowing.status == "approved";
  }

  static bool? isFollowed(UserModel userAuthenticated, UserModel user) {
    SubscriptionModel? userFollower = userAuthenticated.followers!
        .where((subscription) => subscription!.followerId == user.id!)
        .firstOrNull;
    if (userFollower == null) {
      return null;
    }
    return userFollower.status == "approved";
  }
}
