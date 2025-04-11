import 'package:flutter/material.dart';

class PaymentCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 215, 244, 237), // Jaune clair
          borderRadius: BorderRadius.circular(20),

        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "345 721 094 839",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Icon(Icons.edit, color: Colors.black54),
              ],
            ),
            SizedBox(height: 8),
            Text(
              "15 / 18 participants",
              style: TextStyle(
                fontSize: 12,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "26,500 AR",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),

              ),
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildButton(Icons.payment, "Details"),
                  _buildButton(Icons.download, "Exporter"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.black54),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}
