import 'package:flutter/material.dart';
import 'package:sola/presentation/UI/config/theme.dart';
import 'package:sola/presentation/UI/widgets/bottom_sheet/input_field.dart'; // Assure-toi que le chemin est correct

class EditDepenseSheet extends StatefulWidget {
  final int? montant;
  final String motif;
  final Future<void> Function(int? nouveauMontant, String nouveauMotif) onSave;

  const EditDepenseSheet({
    super.key,
    required this.montant,
    required this.motif,
    required this.onSave,
  });

  @override
  State<EditDepenseSheet> createState() => _EditDepenseSheetState();
}

class _EditDepenseSheetState extends State<EditDepenseSheet> {
  late TextEditingController montantController;
  late TextEditingController motifController;

  @override
  void initState() {
    super.initState();
    montantController = TextEditingController(text: widget.montant.toString());
    motifController = TextEditingController(text: widget.motif);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Modifier la dépense",
            ),
            const SizedBox(height: 16),

            // Champs de texte réutilisables
            buildEditableInputField(
              icon: Icons.money,
              hint: "Montant",
              controller: montantController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            buildEditableInputField(
              icon: Icons.flag,
              hint: "Motif",
              controller: motifController,
            ),

            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () async {
                final nouveauMontant = int.tryParse(montantController.text) ?? widget.montant;
                final nouveauMotif = motifController.text.trim();
                await widget.onSave(nouveauMontant, nouveauMotif);
                Navigator.pop(context);
              },
              icon: const Icon(Icons.save),
              label: const Text("Enregistrer"),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                minimumSize: const Size(double.infinity, 48),
                foregroundColor: Colors.white
              ),
            ),
          ],
        ),
      ),
    );
  }
}
