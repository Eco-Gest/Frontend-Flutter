import 'package:ecogest_front/data/ecogest_api_data_source.dart';
import 'package:ecogest_front/models/post_model.dart';
import 'package:ecogest_front/services/authentication_service.dart';

abstract class PostsService {
  static Future<List<PostModel>> getPosts(int pageNbr) async {
    final String? token = await AuthenticationService.getToken();
    final Map<String, dynamic> responseMap =
        await EcoGestApiDataSource.get('/posts?page=$pageNbr', token: token);

    if (responseMap.containsKey('data')) {
      // Data key contains the list of 30 posts
      final List<dynamic> responseData = responseMap['data'];
      final List<PostModel> posts = responseData.map((post) {
        return PostModel.fromJson(post);
      }).toList();
      return posts;
    } else {
      return [];
    }
  }

  static Future<PostModel> getOnePost(int postId) async {
    final String? token = await AuthenticationService.getToken();
    final post = await EcoGestApiDataSource.get('/posts/$postId', token: token);

    return PostModel.fromJson(post);
  }

  static int likeCount(PostModel post) {
    final int? likes = post.likes?.length;
    if (likes != null && likes > 0) {
      return likes;
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

  static Future<void> toggleLike(int postId, bool isLiked) async {
    final String? token = await AuthenticationService.getToken();

    if (isLiked) {
      return await EcoGestApiDataSource.delete('/posts/$postId/likes', {},
          error: 'Failed to add like', token: token);
    } else {
      await EcoGestApiDataSource.post('/posts/$postId/likes', {},
          error: 'Failed to add like', token: token);
    }
  }

  static Future<bool> removeLike(int postId) async {
    final String? token = await AuthenticationService.getToken();
    final body = {
      'post_id': postId,
    };
    await EcoGestApiDataSource.delete('/posts/$postId/likes', body,
        error: 'Failed to remove like', token: token);
    return false;
  }
}
