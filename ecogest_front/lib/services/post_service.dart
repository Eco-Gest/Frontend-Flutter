import 'package:ecogest_front/data/ecogest_api_data_source.dart';
import 'package:ecogest_front/models/post_model.dart';
import 'package:ecogest_front/services/authentication_service.dart';

abstract class PostService {
  static Future<List<PostModel>> getPosts(int pageNbr) async {
    final String? token = await AuthenticationService.getToken();
    final List<dynamic> responseMap =
        await EcoGestApiDataSource.get('/posts?page=$pageNbr', token: token);

    final List<PostModel> posts = responseMap.map((post) {
      return PostModel.fromJson(post);
    }).toList();

    return posts;

  }

  static Future<List<PostModel>> getUserPostsFiltered(
      String backendRoute) async {
    final String? token = await AuthenticationService.getToken();
    final List<dynamic> responseMap =
        await EcoGestApiDataSource.get(backendRoute, token: token);

    final List<PostModel> posts = responseMap.map((post) {
      return PostModel.fromJson(post);
    }).toList();

    return posts;
  }

  static Future<PostModel> getOnePost(int postId) async {
    final String? token = await AuthenticationService.getToken();
    final post = await EcoGestApiDataSource.get('/posts/$postId', token: token);
    return PostModel.fromJson(post);
  }

  static Future<PostModel> createPost(PostModel postModel) async {
    final String? token = await AuthenticationService.getToken();
    final body = postModel.toJson();
    await EcoGestApiDataSource.post('/posts', body, token: token);
    return postModel;
  }

  static Future<PostModel> updatePost(PostModel postModel) async {
    final String? token = await AuthenticationService.getToken();
    final body = postModel.toJson();
    await EcoGestApiDataSource.patch('/posts/${postModel.id}', body, token: token);
    return postModel;
  }
}
