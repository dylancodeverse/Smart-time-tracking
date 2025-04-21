import 'package:flutter/material.dart';
import 'package:sola/presentation/UI/config/theme.dart';
import 'package:sola/presentation/UI/widgets/bottom_sheet/input_field.dart';

class EditParticipationBottomListSheet extends StatefulWidget {
  final int montant;
  final String immatriculation;
  final Future<void> Function(int nouveauMontant) onSave;

  const EditParticipationBottomListSheet({
    super.key,
    required this.montant,
    required this.onSave,
    required this.immatriculation,
  });

  @override
  State<EditParticipationBottomListSheet> createState() => _EditParticipationBottomListSheetState();
}

class _EditParticipationBottomListSheetState extends State<EditParticipationBottomListSheet> {
  late TextEditingController montantController;

  @override
  void initState() {
    super.initState();
    montantController = TextEditingController(text: widget.montant.toString());
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
              "Modifier la participation",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            buildEditableInputField(
              icon: Icons.money,
              hint: "Montant",
              controller: montantController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            buildInputField(
              Icons.flag,
              widget.immatriculation,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () async {
                final nouveauMontant = int.tryParse(montantController.text) ?? widget.montant;
                await widget.onSave(nouveauMontant);
                Navigator.pop(context);
              },
              icon: const Icon(Icons.save),
              label: const Text("Enregistrer"),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                minimumSize: const Size(double.infinity, 48),
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
