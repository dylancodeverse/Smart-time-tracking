import 'package:flutter/material.dart';
import 'package:sola/presentation/UI/config/theme.dart';

class BusEditOption extends StatelessWidget {
  final VoidCallback onTap;

  const BusEditOption({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Action à exécuter lors du tap
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: AppTheme.scaff,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 4)],
        ),
        child: Icon(Icons.edit, color: Colors.blueAccent, size: 16),
      ),
    );
  }
}
