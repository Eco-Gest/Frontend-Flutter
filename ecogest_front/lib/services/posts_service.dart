import 'package:ecogest_front/data/ecogest_api_data_source.dart';
import 'package:ecogest_front/models/post_model.dart';
import 'package:ecogest_front/services/authentication_service.dart';

abstract class PostsService {
  static Future<List<PostModel>> getPosts() async {
    final String? token = await AuthenticationService.getToken();
    final posts = await EcoGestApiDataSource.get('/posts', token: token);
    return posts;
  }

  static Future<PostModel> getOnePost(int postId) async {
    final String? token = await AuthenticationService.getToken();
    final post = await EcoGestApiDataSource.get('/posts/$postId', token: token);
    return PostModel.fromJson(post);
  }
}