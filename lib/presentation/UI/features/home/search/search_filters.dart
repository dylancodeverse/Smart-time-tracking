import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sola/presentation/model/filter/filter_home.dart';
import 'package:sola/presentation/providers/home/search_filter_provider.dart';

class SearchFilters extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final filterProvider = Provider.of<FilterProvider>(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: FutureBuilder(
          future: filterProvider.getFilterList(),
          builder: (context, AsyncSnapshot<List<FilterHome>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();  // Afficher un indicateur de chargement
            }

            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');  // Afficher une erreur si le chargement échoue
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text('No filters available');  // Afficher un message s'il n'y a pas de données
            }

            // Si les données sont présentes et prêtes
            final filterList = snapshot.data!;
            return Row(
              children: filterList.map((filterElement) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: _FilterButton(
                    label: filterElement.lib,
                    isActive: filterProvider.selectedFilter == filterElement.lib,
                    onTap: () => filterProvider.setSelectedFilter(context, filterElement.lib),
                    notificationCount: filterElement.notificationCount,
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}

class _FilterButton extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  final int notificationCount; // Ajout du compteur de notifications

  const _FilterButton({
    required this.label,
    required this.isActive,
    required this.onTap,
    this.notificationCount = 0, // Valeur par défaut à 0
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none, // Permet au badge de dépasser du bouton
      children: [
        ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: isActive ? const Color(0xFF008069) : Colors.grey[300], // Vert actif, gris sinon
            foregroundColor: isActive ? Colors.white : Colors.black, // Texte
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Text(label, style: const TextStyle(fontSize: 12)),
        ),

        // Badge de notification (affiché seulement si notificationCount > 0)
        if (notificationCount > 0)
          Positioned(
            right: -5, // Décale légèrement à droite
            top: -5,   // Décale légèrement en haut
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
                border: Border.all(color: Color(0xFFF2F9F7), width: 1), // Bordure blanche pour le contraste
              ),
              constraints: const BoxConstraints(
                minWidth: 20,
                minHeight: 20,
              ),
              child: Text(
                notificationCount.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}

