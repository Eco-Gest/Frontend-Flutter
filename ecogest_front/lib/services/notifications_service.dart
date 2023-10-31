import 'package:ecogest_front/data/ecogest_api_data_source.dart';
import 'package:ecogest_front/models/notification_model.dart';
import 'package:ecogest_front/services/authentication_service.dart';

class NotificationsService {
  static Future<List<NotificationModel>?> getNotifications() async {
    final String? token = await AuthenticationService.getToken();

    final List<dynamic> responseMap =
        await EcoGestApiDataSource.get('/me/notifications', token: token);

    final List<NotificationModel> trophies = responseMap.map((trophy) {
      return NotificationModel.fromJson(trophy);
    }).toList();

    return trophies;
  }
}
