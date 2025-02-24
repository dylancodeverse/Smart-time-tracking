import 'package:flutter/material.dart';

class GestureDetectorModal extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final IconData icon;
  final Color backgroundColor;
  final Color textColor;

  const GestureDetectorModal({
    Key? key,
    required this.text,
    required this.onTap,
    this.icon = Icons.warning_amber_rounded,
    this.backgroundColor = const Color(0xFFE0E0E0), // Gris clair
    this.textColor = Colors.black87,
  }) ;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                text,
                style: TextStyle(color: textColor),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Icon(icon, color: Colors.redAccent),
          ],
        ),
      ),
    );
  }
}
