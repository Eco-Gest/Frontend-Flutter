import 'package:ecogest_front/data/ecogest_api_data_source.dart';
import 'package:ecogest_front/models/user_model.dart';
import 'package:ecogest_front/services/notifications/notifications_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pusher_beams/pusher_beams.dart';

class AuthenticationService {
  static final NotificationsService notificationsService =
      NotificationsService();

  static Future<void> login({
    required String email,
    required String password,
  }) async {
    // Check if the email and password are valid
    if (email.isEmpty || password.isEmpty) {
      throw Exception('Invalid email or password');
    }

    // We create a request object to send to the API
    final request = {
      'email': email,
      'password': password,
    };

    // We send the request to the API and get the response
    final response = await EcoGestApiDataSource.post('/login', request,
        error: 'Failed to login');

    // We get the token from the response
    String token;
    try {
      token = response['access_token'];
    } catch (e) {
      // If the token is not in the response, throw an error
      throw Exception('Failed to parse token');
    }

    // We save the token in the local storage
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);

    // connect to pusher
    notificationsService.connectPusher();
  }

  static Future<UserModel> register({
    required String email,
    required String username,
    required String password,
  }) async {
    // Check if the email and password are valid
    if (email.isEmpty || password.isEmpty || username.isEmpty) {
      throw Exception('Invalid email, username or password');
    }

    // We create a request object to send to the API
    final request = {
      'email': email,
      'username': username,
      'password': password,
    };

    // We send the request to the API and get the response
    final response = await EcoGestApiDataSource.post('/register', request,
        error: 'Failed to register');

    if (response['message'] != null) {
      throw Exception(response['message']);
    }
    // We get the token from the response
    String token;
    try {
      token = response['access_token'];
    } catch (e) {
      // If the token is not in the response, throw an error
      throw Exception('Failed to parse token');
    }

    // We save the token in the local storage
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);

    // connect to pusher
    notificationsService.connectPusher();

    return UserModel.fromJson(response);
  }

  static Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    // end connection to pusher
    notificationsService.disconnectPusher();
    PusherBeams.instance.clearDeviceInterests();
  }

  static Future<String?> getToken() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString('token');
    } catch (e) {
      return null;
    }
  }

  static Future<void> resetPassword({
    required String email,
  }) async {
    // Check if the email is valid
    if (email.isEmpty) {
      throw Exception('Invalid email or password');
    }

    // We create a request object to send to the API
    final request = {
      'email': email,
    };

    // We send the request to the API and get the response
    final response = await EcoGestApiDataSource.post('/request-reset-password', request,
        error: 'Failed to send mail to reset password');
    return response;
  }

  
  static Future<void> deleteMyAccount() async {
      final String? token = await AuthenticationService.getToken();

      await EcoGestApiDataSource.delete(
        '/me',
        token: token,
      );

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      
      // end connection to pusher
      notificationsService.disconnectPusher();
      PusherBeams.instance.clearDeviceInterests();
  }
}
