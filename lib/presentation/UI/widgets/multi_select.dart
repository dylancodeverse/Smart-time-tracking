// Multi Select widget
// This widget is reusable
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sola/presentation/UI/config/theme.dart';
import 'package:sola/presentation/UI/widgets/modal_object.dart';
import 'package:sola/presentation/providers/arrival_declaration/modal_provider.dart';

class MultiSelect extends StatelessWidget {
  const MultiSelect({super.key});

  @override
  Widget build(BuildContext context) {
    ModalProvider provider= Provider.of<ModalProvider>(context, listen: false);
    List< ModalObject> items= provider.objectInit;    

    return Consumer<ModalProvider>(
      builder: (context, myProvider, child) {
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
              children: items
                  .map((item) => CheckboxListTile(
                        value: item.isChecked,
                        title: Text(
                          item.lib,
                          style: TextStyle(
                            fontSize: 16, // ✅ Taille de la police des options
                            color: Colors.black, // ✅ Couleur du texte
                          ),
                        ),
                        controlAffinity: ListTileControlAffinity.leading,
                        onChanged: (isChecked) => _itemChange(provider,item),
                      ))
                  .toList(),
            ),
          ),
          
          actions: [
            TextButton(
              onPressed: ()=> _cancel(context),
              style: TextButton.styleFrom(
                foregroundColor: Colors.redAccent, // ✅ Couleur du bouton "Annuler"
                textStyle: TextStyle(fontSize: 16), // ✅ Taille de la police du bouton
              ),
              child: const Text('Annuler'),
            ),
            ElevatedButton(
              onPressed:()=> _submit(context),
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
    );    
  }


  // This function is triggered when a checkbox is checked or unchecked
  void _itemChange( ModalProvider provider ,ModalObject itemValue) {
    provider.setObjectIni(itemValue);
  }

  // this function is called when the Cancel button is pressed
  void _cancel(BuildContext context) {
    Navigator.pop(context);
  }

  // this function is called when the Submit button is tapped
  void _submit(BuildContext context) {
    Navigator.pop(context);
  }
}
