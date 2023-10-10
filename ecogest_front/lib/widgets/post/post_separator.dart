import 'package:flutter/material.dart';

class PostSeparator extends StatelessWidget {
  const PostSeparator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Divider(
          height: 10,
          thickness: 1,
          indent: 20,
          endIndent: 20,
          color: Colors.grey,
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}