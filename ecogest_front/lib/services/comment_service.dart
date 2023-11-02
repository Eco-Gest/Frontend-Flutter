import 'package:ecogest_front/data/ecogest_api_data_source.dart';
import 'package:ecogest_front/models/comment_model.dart';
import 'package:ecogest_front/services/authentication_service.dart';

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
}
