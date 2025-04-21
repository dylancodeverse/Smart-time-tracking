import 'package:flutter/material.dart';
import 'package:sola/presentation/UI/config/theme.dart';

Widget buildEditableInputField({
  required IconData icon,
  required String hint,
  required TextEditingController controller,
  TextInputType keyboardType = TextInputType.text, // Ajout du paramètre
}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    height: 50,
    decoration: BoxDecoration(
      color: Colors.grey[100],
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.black54),
        SizedBox(width: 12),
        Expanded(
          child: TextField(
            controller: controller,
            keyboardType: keyboardType, // Utilisation ici
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.black54),
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildInputField(IconData icon, String hint) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    decoration: BoxDecoration(
      color: Colors.grey[100],
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.black54),
        SizedBox(width: 12),
        Text(hint, style: TextStyle(color: Colors.black54)),
      ],
    ),
  );
}

Widget buildTab(String title, bool isSelected) {
  return Text(
    title,
    style: TextStyle(
      fontSize: 16,
      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      color: isSelected ? Colors.green : Colors.black54,
    ),
  );
}

  Widget buildButton(IconData icon, String label, Color buttonColor, BuildContext context, Widget content) {
    return Column(
      children: [
        InkWell(
          onTap: () => showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (_) => content,
          ),
          child:Icon(icon, color: buttonColor),
        ),  
        SizedBox(height: 4),
        Text(label, style: AppTheme.bodyMediu),
      ],
    );
  }