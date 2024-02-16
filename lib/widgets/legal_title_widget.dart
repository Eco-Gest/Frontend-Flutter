import 'package:flutter/material.dart';

class LegalTitle extends StatelessWidget {
  const LegalTitle({
    super.key,
    required this.textContent,
    this.textSize,
  });

  final String textContent;
  final double? textSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(textContent,
          style: TextStyle(
            fontSize: textSize ?? 16,
            fontWeight: FontWeight.bold,
          )),
    );
  }
}
