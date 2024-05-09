import 'dart:convert';
import 'package:flutter_config/flutter_config.dart';
import 'package:crypto/crypto.dart';
import 'package:ecogest_front/data/ecogest_api_data_source.dart';
import 'package:ecogest_front/models/notification_model.dart';
import 'package:ecogest_front/services/authentication_service.dart';
import 'package:ecogest_front/services/notifications/local_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationsService {
  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();

  final localNotificationService = LocalNotificationService();
  NotificationsService() {
    localNotificationService.initialize();
  }

  static Future<List<NotificationModel>?> getNotifications() async {
    final String? token = await AuthenticationService.getToken();

    final List<dynamic> responseMap =
        await EcoGestApiDataSource.get('/me/notifications', token: token);

    final List<NotificationModel> notifications = responseMap.map((notif) {
      return NotificationModel.fromJson(notif);
    }).toList();

    return notifications;
  }

  connectPusher() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');

    try {
      await pusher.init(
        apiKey: FlutterConfig.get('PUSHER_APP_KEY').toString(),
        cluster: FlutterConfig.get('PUSHER_APP_CLUSTER').toString(),
        onEvent: onEvent,
        onAuthorizer: onAuthorizer,
      );

      // event new comment
      await pusher.subscribe(channelName: "private-comment.user.$userId");

      // event new like
      await pusher.subscribe(channelName: "private-like.user.$userId");

      // event new subscription : new subscription asked to user or subscription request's accepted
      await pusher.subscribe(channelName: "private-subscription.user.$userId");

      await pusher.connect();
    } catch (e) {
      debugPrint("ERROR: $e");
    }
  }

  disconnectPusher() async {
    await pusher.disconnect();
  }

  void onEvent(dynamic event) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    String? message = jsonDecode(event.data.toString())['message'].toString();

    if (message != "null") {
      if (event.channelName.toString().contains("private-subscription.user")) {
        // new subscription request for authenticated user
        var user =
            jsonDecode(event.data.toString())['subscription']['follower'];
        if (userId == user.id) {
          // the following accept user authenticated request subscription
          var user =
              jsonDecode(event.data.toString())['subscription']['following'];
        }
        await localNotificationService.showNotificiation(
            id: user['id'], title: message, payload: "/users/${user['id']}");
      } else if (event.channelName.toString().contains("private-like.user") ||
          event.channelName.toString().contains("private-comment.user")) {
        final post = jsonDecode(event.data.toString())['post'];

        await localNotificationService.showNotificiation(
            id: post['id'], title: message, payload: "/posts/${post['id']}");
      }
    }
  }

  getSignature(String value) {
    final key = utf8.encode(FlutterConfig.get('PUSHER_APP_SECRET').toString());
    final bytes = utf8.encode(value);

    final hmacSha256 = Hmac(sha256, key); // HMAC-SHA256
    final digest = hmacSha256.convert(bytes);
    return digest;
  }

  dynamic onAuthorizer(String channelName, String socketId, dynamic options) {
    return {
      "auth":
          "${FlutterConfig.get('PUSHER_APP_KEY')}:${getSignature("$socketId:$channelName")}",
    };
  }
}
