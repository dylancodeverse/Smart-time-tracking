import 'package:flutter/material.dart';
import 'package:sola/presentation/UI/config/theme.dart';

class Bottomnav extends StatelessWidget {
  final int currentIndex;

  const Bottomnav({super.key, required this.currentIndex});

  void _onItemTapped(BuildContext context, int index) {
    if (index == currentIndex) return;

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/summary');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/settings');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: AppTheme.scaff,
      selectedItemColor: AppTheme.primaryColor,
      unselectedItemColor: const Color.fromARGB(255, 42, 42, 42),
      unselectedLabelStyle: AppTheme.smallText,
      selectedLabelStyle: AppTheme.smallText,
      currentIndex: currentIndex,
      onTap: (index) => _onItemTapped(context, index),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Résumé'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Paramètres'),
      ],
    );
  }
}
