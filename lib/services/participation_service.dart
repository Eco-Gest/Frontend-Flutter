import 'package:ecogest_front/data/ecogest_api_data_source.dart';
import 'package:ecogest_front/services/authentication_service.dart';

abstract class ParticipationService {
  static Future<void> createParticipation(int postId) async {
    final String? token = await AuthenticationService.getToken();
    await EcoGestApiDataSource.post('/posts/$postId/participants', {},
        token: token);
  }
  static Future<void> endChallenge(int postId) async {
    final String? token = await AuthenticationService.getToken();
    await EcoGestApiDataSource.patch('/posts/$postId/participants/completed', {},
        token: token);
  }
}
