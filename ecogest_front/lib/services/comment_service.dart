import 'package:ecogest_front/data/ecogest_api_data_source.dart';
import 'package:ecogest_front/models/comment_model.dart';
import 'package:ecogest_front/services/authentication_service.dart';
import 'package:flutter/material.dart';

abstract class CommentService {
  static Future<CommentModel> createComment(String content, int postId) async {
    final String? token = await AuthenticationService.getToken();
    final comment = CommentModel(content: content, postId: postId);
    final body = comment.toJson();
    final responseMap = await EcoGestApiDataSource.post(
        '/posts/$postId/comments', body,
        token: token);

    return CommentModel.fromJson(responseMap);
  }

  static Future<void> deleteComment(int commentId) async {
    final String? token = await AuthenticationService.getToken();
    final response = await EcoGestApiDataSource.delete(
      '/posts/comments/$commentId', {},
      token: token,
    );
    if (response.statusCode == 200) {
      // La suppression a réussi.
    } else {
      // La suppression a échoué. Vous pouvez émettre une exception ou gérer l'erreur d'une autre manière.
      throw Exception('Échec de la suppression du message');
    }
  }
  
  static Future<void> submitReport(int commentId, int authorId, String content, String result) async {
  try {
    final String? token = await AuthenticationService.getToken();

      final Map<String, dynamic> requestBody = {
        'ID': commentId,
        'Title': 'commentaire',
        'authorID': authorId,
        'result': result,
        'Content': content,
      };

      await EcoGestApiDataSource.post('/submit-report', requestBody, token: token);

    } catch (error) {
      throw Exception('Échec du signalement');
    }
  }
}
