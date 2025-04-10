import 'package:flutter/material.dart';

class ErrorActionModal {
  static void show(
    BuildContext context, {
    required String title,
    required String description,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.block, color: Colors.red), // Icône d'avertissement
              SizedBox(width: 8),
              Text(title, style: TextStyle(color: Colors.red)),
            ],
          ),
          content: Text(description),
          backgroundColor: Colors.white,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Ferme le modal
              },
              child: Text("OK", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
