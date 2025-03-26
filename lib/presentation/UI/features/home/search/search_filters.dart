import 'package:flutter/material.dart';

class SearchFilters extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal, // Permet le défilement horizontal
        child: Row(
          children: [
            _FilterButton(label: 'Tous'),
            SizedBox(width: 8), // Ajoute un espace entre les boutons
            _FilterButton(label: 'N\'ont pas encore payé'),
            SizedBox(width: 8), // Ajoute un espace entre les boutons
            _FilterButton(label: 'Arrivées'),
            SizedBox(width: 8),
            _FilterButton(label: 'Ont payé'),
            SizedBox(width: 8),
            _FilterButton(label: 'Sur route'),
          ],
        ),
      ),
    );
  }
}


class _FilterButton extends StatelessWidget {
  final String label;

  const _FilterButton({required this.label});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Action à effectuer lors du clic sur un filtre
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Color(0xFF008069), // Couleur de fond (vert foncé WhatsApp)
        backgroundColor: Colors.white, // Couleur du texte et des icônes (vert clair)

        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(label, style: TextStyle(fontSize: 15)),
    );
  }
}
