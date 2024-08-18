// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class AnswerTile extends StatelessWidget {
  const AnswerTile({
    super.key,
    required this.answer,
    required this.bgColor,
    required this.onTap,
    this.useTrailing = false,
  });

  final String answer;
  final Color bgColor;
  final VoidCallback onTap;
  final bool useTrailing;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            border: Border.all(color: bgColor, width: 1),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              answer,
              style: TextStyle(fontSize: 16, color: bgColor),
            ),
            useTrailing
                ? Icon(
                    Icons.check_circle_outline_rounded,
                    color: bgColor,
                  )
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
