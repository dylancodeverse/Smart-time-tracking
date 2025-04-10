import 'package:flutter/material.dart';

class ConfirmationModal {
  static Future<void> show(
    BuildContext context, {
    required String title,
    required String description,
    required VoidCallback onProceed,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,

      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          content: Text(description),
          backgroundColor: Colors.white,          
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Annuler", style: TextStyle(color: Colors.red)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                onProceed();
              },

              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF008069),
                foregroundColor: Colors.white 
              ),
              child: Text("Procéder"),

            ),
          ],
        );
      },
    );
  }
}
