import 'package:ecogest_front/data/ecogest_api_data_source.dart';
import 'package:ecogest_front/models/post_model.dart';
import 'package:ecogest_front/services/authentication_service.dart';

class PostService {
  List<PostModel> allPosts = List.empty();

  Future<List<PostModel>> getPosts(int pageNbr) async {
    final String? token = await AuthenticationService.getToken();
    final List<dynamic> responseMap =
        await EcoGestApiDataSource.get('/posts?page=$pageNbr', token: token);

    if (allPosts.isNotEmpty && pageNbr == 1) {
      return allPosts;
    } else if (allPosts.isEmpty && pageNbr == 1) {
      final posts = responseMap.map((post) {
        return PostModel.fromJson(post);
      }).toList();
      allPosts += posts;
      return allPosts;
    } else if (allPosts.length >= pageNbr * 8) {
      return allPosts;
    }
    final List<PostModel> posts = responseMap.map((post) {
      return PostModel.fromJson(post);
    }).toList();
    allPosts += posts;
    return allPosts;
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

  Future<PostModel> getOnePost(int postId) async {
    for (PostModel post in allPosts) {
      if (post.id! == postId) {
        return post;
      }
    }
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
}
