import 'package:flutter/material.dart';
import 'package:sola/presentation/UI/config/theme.dart';

class CustomizedSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(BuildContext,String) onSearch;

  const CustomizedSearchBar({required this.controller, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),

      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'Rechercher un véhicule',
          prefixIcon: Icon(Icons.search, color: AppTheme.primaryColor),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 10), // Hauteur réduite
          border: OutlineInputBorder(                                                        
            borderRadius: BorderRadius.circular(30), // Plus arrondi
            borderSide: BorderSide.none, // Suppression de la bordure
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          suffixIcon: IconButton(
            icon: Icon(Icons.clear, color: AppTheme.primaryColor),
            onPressed: () => controller.clear(),
          ),
        ),
        onChanged: (value)=>onSearch(context,value),
      ),
    );
  }
}
