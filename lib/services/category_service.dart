import 'package:ecogest_front/data/ecogest_api_data_source.dart';
import 'package:ecogest_front/models/category_model.dart';
import 'package:ecogest_front/services/authentication_service.dart';

class CategoryService {

  List<CategoryModel> allCategories = [];

  Future<List<CategoryModel>> getCategories() async {
    final String? token = await AuthenticationService.getToken();
    if (allCategories.isEmpty) {
      final List<dynamic> responseMap =
          await EcoGestApiDataSource.get('/categories', token: token);

      final List<CategoryModel> categories = responseMap.map((category) {
        return CategoryModel.fromJson(category);
      }).toList();
      allCategories = categories;
    }
    return allCategories;
  }
}
