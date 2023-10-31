import 'package:ecogest_front/data/ecogest_api_data_source.dart';
import 'package:ecogest_front/models/comment_model.dart';
import 'package:ecogest_front/services/authentication_service.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

abstract class CommentService {
  static Future<CommentModel> createComment(String content, int postId) async {
    debugPrint('Là ?');
    final String? token = await AuthenticationService.getToken();

    final body = jsonEncode(<String, String>{
      'content': content,
    });

    final response = await EcoGestApiDataSource.post('posts/$postId/comments', body, token: token);
    if (response.statusCode == 201) {
      return CommentModel.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Eurreur à la création du commentaire');
    }
  }
}