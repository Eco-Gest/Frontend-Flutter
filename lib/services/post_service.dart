import 'package:ecogest_front/data/ecogest_api_data_source.dart';
import 'package:ecogest_front/models/post_model.dart';
import 'package:ecogest_front/services/authentication_service.dart';
import 'package:ecogest_front/services/notifications/notifications_service.dart';
import 'package:flutter/material.dart';

class PostService {
  List<PostModel> allPosts = [];
  List<PostModel>? completedPosts;
  List<PostModel>? nextPosts;
  List<PostModel>? inProgressPosts;
  List<PostModel>? actionsPosts;
  static final NotificationsService notificationsService =
      NotificationsService();

  Future<List<PostModel>> getPosts(int pageNbr, bool forceReload) async {
    final String? token = await AuthenticationService.getToken();

    if (allPosts.isEmpty || pageNbr > 1 || forceReload) {
      final List<dynamic> responseMap =
          await EcoGestApiDataSource.get('/posts?page=$pageNbr', token: token);

      final posts = responseMap.map((post) {
        return PostModel.fromJson(post);
      }).toList();
      allPosts = posts;
    }
    // connect to pusher
    notificationsService.connectPusher();
    return allPosts;
  }

  Future<List<PostModel>?> getUserPostsFiltered(
      String keywordRoute, int userId) async {
    final String? token = await AuthenticationService.getToken();

    switch (keywordRoute) {
      case ("completed"):
        return getCompletedPosts(keywordRoute, token, userId);
      case ("next"):
        return getNextPosts(keywordRoute, token, userId);
      case ("inProgress"):
        return getInProgressPosts(keywordRoute, token, userId);
      case ("actions"):
        return getActionsPosts(keywordRoute, token, userId);
    }
    return null;
  }

  Future<List<PostModel>?> getCompletedPosts(
      String keywordRoute, String? token, int userId) async {
    String backendRoute = '/users/$userId/challenges/completed';

    final List<dynamic> responseMap =
        await EcoGestApiDataSource.get(backendRoute, token: token);
    return responseMap.map((post) {
      return PostModel.fromJson(post);
    }).toList();
  }

  Future<List<PostModel>?> getNextPosts(
      String keywordRoute, String? token, int userId) async {
    String backendRoute = '/users/$userId/challenges/next';

    final List<dynamic> responseMap =
        await EcoGestApiDataSource.get(backendRoute, token: token);
    return responseMap.map((post) {
      return PostModel.fromJson(post);
    }).toList();
  }

  Future<List<PostModel>?> getInProgressPosts(
      String keywordRoute, String? token, int userId) async {
    String backendRoute = '/users/$userId/challenges/in-progress';

    final List<dynamic> responseMap =
        await EcoGestApiDataSource.get(backendRoute, token: token);
    return responseMap.map((post) {
      return PostModel.fromJson(post);
    }).toList();
  }

  Future<List<PostModel>?> getActionsPosts(
      String keywordRoute, String? token, int userId) async {
    String backendRoute = '/users/$userId/actions';

    final List<dynamic> responseMap =
        await EcoGestApiDataSource.get(backendRoute, token: token);
    return responseMap.map((post) {
      return PostModel.fromJson(post);
    }).toList();
  }

  Future<PostModel> getOnePost(int postId, bool forceReload) async {
    if (!forceReload) {
      for (PostModel post in allPosts) {
        if (post.id! == postId) {
          return post;
        }
      }
    }
    final String? token = await AuthenticationService.getToken();
    final post = await EcoGestApiDataSource.get('/posts/$postId', token: token);
    return PostModel.fromJson(post);
  }

  Future<PostModel> createPost(PostModel postModel) async {
    final String? token = await AuthenticationService.getToken();
    final body = postModel.toJson();

    final result =
        await EcoGestApiDataSource.post('/posts', body, token: token);

    if (postModel.image != null) {
      await EcoGestApiDataSource.addImage(
          '/posts/${result['id']}/uploadImage', postModel.image!,
          token: token);
    }

    allPosts.insert(0, PostModel.fromJson(result));

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

  Future<PostModel> updatePost(PostModel postModel) async {
    final String? token = await AuthenticationService.getToken();

    final body = postModel.toJson();

    final result = await EcoGestApiDataSource.patch(
        '/posts/${postModel.id}', body,
        token: token);

    if (result['error'] != null) {
      throw Exception(result['error']);
    }

    if (postModel.image != null) {
      await EcoGestApiDataSource.addImage(
          '/posts/${result['id']}/uploadImage', postModel.image!,
          token: token);
    }

    return postModel;
  }

  static Future<void> deletePost(int postId) async {
    final String? token = await AuthenticationService.getToken();

    await EcoGestApiDataSource.delete(
      '/posts/$postId',
      {},
      token: token,
    );
  }

  Future<void> submitReport(int postId, String result) async {
    try {
      final String? token = await AuthenticationService.getToken();

      getOnePost(postId, false).then((PostModel post) async {
        final Map<String, dynamic> requestBody = {
          'ID': post.id,
          'title': post.title,
          'authorID': post.authorId,
          'result': result,
          'content': post.description,
        };

        await EcoGestApiDataSource.post('/submit-report', requestBody,
            token: token);
      });
    } catch (error) {
      throw Exception('Échec du signalement');
    }
  }
}
