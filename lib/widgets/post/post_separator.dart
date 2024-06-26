import 'package:flutter/material.dart';
import 'package:ecogest_front/assets/ecogest_theme.dart';

class PostSeparator extends StatelessWidget {
  const PostSeparator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 5,
        ),
        Divider(
          height: 10,
          thickness: 1,
          color: lightColorScheme.outline,
        ),
        SizedBox(
          height: 5,
        ),
      ],
    );
  }
}