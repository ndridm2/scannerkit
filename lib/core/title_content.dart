import 'package:flutter/material.dart';

class TitleContent extends StatelessWidget {
  final String title;
  final VoidCallback onSeeAllTap;

  const TitleContent({
    super.key,
    required this.title,
    required this.onSeeAllTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
          ),
        )
      ],
    );
  }
}
