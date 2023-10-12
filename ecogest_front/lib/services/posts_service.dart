import 'package:ecogest_front/data/ecogest_api_data_source.dart';
import 'package:ecogest_front/models/post_model.dart';
import 'package:ecogest_front/services/authentication_service.dart';
import 'package:flutter/material.dart';

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
}
