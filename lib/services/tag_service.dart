import 'package:ecogest_front/data/ecogest_api_data_source.dart';
import 'package:ecogest_front/models/tag_model.dart';
import 'package:ecogest_front/services/authentication_service.dart';


class TagService {
    static Future<List<TagModel>> getTagModels(String query) async {
         // 3. Get the authentication token.
    final String? token = await AuthenticationService.getToken();
    
    // 4. Make the API request using the user ID.
    final List<dynamic> responseMap = await EcoGestApiDataSource.get('/tags', token: token); 

    // 5. Map the response to a list of tags.
    final List<TagModel> tags = responseMap.map((tag) {
      return TagModel.fromJson(tag);
    }).toList();

    // 6. Return the list of tags.
    return tags;
  }
}