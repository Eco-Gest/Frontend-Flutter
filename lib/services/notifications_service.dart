import 'package:ecogest_front/data/ecogest_api_data_source.dart';
import 'package:ecogest_front/models/notification_model.dart';
import 'package:ecogest_front/services/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class NotificationsService {
  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();

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
    try {
      await pusher.init(
          apiKey: 'cee45c47198b0c3254e4',
          cluster: 'eu',
          onEvent: (event) {
            debugPrint("Got event: $event");
          });
      await pusher.subscribe(channelName: 'private-App.Models.User.1');
      await pusher.connect();
      debugPrint("success");
    } catch (e) {
      debugPrint("ERROR: $e");
    }
  }

  disconnectPusher() async {
    await pusher.disconnect();
  }
}
