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

  static int likeCount(PostModel post) {
    final int? likes = post.likes?.length;
    if (likes != null && likes > 0) {
      return likes ;
    } else {
      return 0;
    }
  }

  static bool userLikedPost(PostModel post, int? userId) {
    if (post.likes != null) {
    // Vérifie si l'ID de l'utilisateur est présent dans la liste des likes
    return post.likes!.any((like) => like.userId == userId);
  }
  return false; // Si la liste des likes est null ou vide, l'utilisateur n'a pas aimé le post
  }

  static Future<bool> addLike(int postId) async {
    final String? token = await AuthenticationService.getToken();

    await EcoGestApiDataSource.post('/posts/$postId/likes', {}, error: 'Failed to add like', token: token);
    return true;
  }

  static Future<bool> removeLike(int postId) async {
    final String? token = await AuthenticationService.getToken();
    await EcoGestApiDataSource.delete('/posts/$postId/likes', {}, error: 'Failed to remove like', token: token);
    return false;
  }
}
