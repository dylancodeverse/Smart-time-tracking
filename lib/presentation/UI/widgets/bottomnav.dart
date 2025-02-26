import 'package:flutter/material.dart';
import 'package:sola/presentation/UI/config/theme.dart';


class Bottomnav extends StatelessWidget {
  const Bottomnav({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: AppTheme.scaff,
      selectedItemColor: AppTheme.primaryColor,
      unselectedItemColor: const Color.fromARGB(255, 42, 42, 42),
      unselectedLabelStyle: AppTheme.smallText,
      selectedLabelStyle: AppTheme.smallText,
      currentIndex: 0, // L'élément sélectionné par défaut (peut être modifié dynamiquement)
      onTap: (index) {
        if (index == 0) {
          Navigator.pushNamed(context, "/"); // Redirection vers "/"
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Résumé'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Paramètres'),
      ],
    );
  }
}
