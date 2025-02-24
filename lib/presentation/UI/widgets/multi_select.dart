// Multi Select widget
// This widget is reusable
import 'package:flutter/material.dart';
import 'package:sola/presentation/UI/config/theme.dart';

class MultiSelect extends StatefulWidget {
  final List<String> items;
  const MultiSelect({super.key, required this.items});

  @override
  State<StatefulWidget> createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  // this variable holds the selected items
  final List<String> _selectedItems = [];

// This function is triggered when a checkbox is checked or unchecked
  void _itemChange(String itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedItems.add(itemValue);
      } else {
        _selectedItems.remove(itemValue);
      }
    });
  }
  

  // this function is called when the Cancel button is pressed
  void _cancel() {
    Navigator.pop(context);
  }

// this function is called when the Submit button is tapped
  void _submit() {
    Navigator.pop(context, _selectedItems);
  }

  @override
  Widget build(BuildContext context) {
      print("oaylele");
      print(_selectedItems);

    return AlertDialog(
      backgroundColor: Colors.white, // ✅ Couleur de fond du modal
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // ✅ Coins arrondis
      
      title: Text(
        'Sélectionner',
        style: TextStyle(
          fontSize: 20, // ✅ Taille de la police du titre
          fontWeight: FontWeight.bold, // ✅ Texte en gras
          color: Colors.black87, // ✅ Couleur du texte
        ),
      ),
      
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.items
              .map((item) => CheckboxListTile(
                    value: _selectedItems.contains(item),
                    title: Text(
                      item,
                      style: TextStyle(
                        fontSize: 16, // ✅ Taille de la police des options
                        color: Colors.black, // ✅ Couleur du texte
                      ),
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (isChecked) => _itemChange(item, isChecked!),
                  ))
              .toList(),
        ),
      ),
      
      actions: [
        TextButton(
          onPressed: _cancel,
          style: TextButton.styleFrom(
            foregroundColor: Colors.redAccent, // ✅ Couleur du bouton "Annuler"
            textStyle: TextStyle(fontSize: 16), // ✅ Taille de la police du bouton
          ),
          child: const Text('Annuler'),
        ),
        ElevatedButton(
          onPressed: _submit,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.darkPrimary, // ✅ Couleur du bouton "Valider"
            textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), // ✅ Taille et style
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), // ✅ Coins arrondis
          ),
          child: const Text('Valider', style: TextStyle(color: Colors.white)), // ✅ Texte blanc
        ),
      ],
    );
  }

}