import 'package:ecogest_front/data/ecogest_api_data_source.dart';
import 'package:ecogest_front/models/trophy_model.dart';
import 'package:ecogest_front/models/user_model.dart';
import 'package:ecogest_front/services/authentication_service.dart';
import 'package:ecogest_front/services/user_service.dart';

class TrophyService {
  static Future<List<TrophyModel>> getTrophies() async {
    // 1. Get the user model from the UserService.
    final UserModel? currentUser = await UserService.getCurrentUser();
    
    // 2. Check if the user model is not null and get the user ID.
    final int? userId = currentUser?.id;
    if (userId == null) {
        throw Exception('User id does not exist');
    }

    // 3. Get the authentication token.
    final String? token = await AuthenticationService.getToken();
    
    // 4. Make the API request using the user ID.
    final List<dynamic> responseMap = await EcoGestApiDataSource.get('/users/$userId/categories-points', token: token);

    // 5. Map the response to a list of TrophyModel.
    final List<TrophyModel> trophies = responseMap.map((trophy) {
      return TrophyModel.fromJson(trophy);
    }).toList();

    // 6. Return the list of trophies.
    return trophies;
  }
}
