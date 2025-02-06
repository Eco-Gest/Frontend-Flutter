import 'package:flutter/material.dart';

// PostBodyImage is a widget inside PostBody that
// displays the image of the post if it exists

class PostBodyImage extends StatelessWidget {
  final String? imageUrl;

  const PostBodyImage({Key? key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return imageUrl != null
        ? Image.network(imageUrl!, fit: BoxFit.cover)
        : SizedBox.shrink();
  }
}
