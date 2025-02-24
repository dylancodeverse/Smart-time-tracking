import 'package:flutter/material.dart';
import 'package:sola/presentation/UI/config/color_checker.dart';
import 'package:sola/presentation/UI/config/theme.dart';
import 'package:sola/presentation/UI/features/home/bus_card/bus_details.dart';
import 'package:sola/presentation/UI/features/home/bus_card/bus_info_header.dart';
import 'package:sola/presentation/UI/widgets/bottomnav.dart';
import 'package:sola/presentation/model/daily_statistic.dart';

class ArrivalDeclarationScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final monObjet = ModalRoute.of(context)!.settings.arguments as DailyStatisticView;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(AppTheme.appName),
        scrolledUnderElevation: 0,
      ),
      body: SimpleCardBUS(activeBus: monObjet), 

      bottomNavigationBar: Bottomnav(),
    );
  }
  
} 




class SimpleCardBUS extends StatefulWidget {
  final DailyStatisticView activeBus;

  const SimpleCardBUS({super.key, required this.activeBus});

  @override
  _SimpleCardBUSState createState() => _SimpleCardBUSState();
}

class _SimpleCardBUSState extends State<SimpleCardBUS> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  String? _selectedViolation;

  final List<String> violations = [
    'Excès de vitesse',
    'Non-respect du feu rouge',
    'Stationnement interdit',
    'Usage du téléphone au volant'
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppTheme.cardColor,
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // En-tête du bus
            BusInfoHeader(
              pilotCompleteName: widget.activeBus.driverCompleteName,
              registrationNumber: widget.activeBus.registrationNumber,
            ),
            const SizedBox(height: 12),

            // Détails du bus
            BusDetails(
              libAmount: widget.activeBus.getLibAmount(),
              round: widget.activeBus.getLibRound(),
              status: widget.activeBus.libStatus(),
              statusColor: ColorLib.getColorByStatus(widget.activeBus.status),
              nextActionEstimation: widget.activeBus.nextActionEstimation,
            ),
            const SizedBox(height: 14),

            // Champ de saisie pour le montant
            _buildInputField(
              controller: _amountController,
              hintText: "Saisir le montant",
              icon: Icons.attach_money,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),

            // Champ de saisie pour les commentaires
            _buildInputField(
              controller: _commentController,
              hintText: "Ajouter un commentaire",
              icon: Icons.comment,
              maxLines: 3,
            ),
            const SizedBox(height: 10),

            // Liste déroulante pour sélectionner une violation
            _buildDropdown(),

            const SizedBox(height: 16),

            // Bouton de validation
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  print("Montant: ${_amountController.text}");
                  print("Commentaire: ${_commentController.text}");
                  print("Violation: $_selectedViolation");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.darkPrimary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text('Valider', style: TextStyle(color: AppTheme.scaff)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Widget générique pour les champs de saisie
  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(icon, color: Colors.grey[700]),
        filled: true,
        fillColor: Colors.grey[200], // Fond légèrement grisé
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8), // Bordure plus douce
          borderSide: BorderSide.none, // Suppression de la bordure épaisse
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      ),
    );
  }

  /// Widget pour la liste déroulante des violations
  Widget _buildDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedViolation,
      decoration: InputDecoration(
        hintText: 'Sélectionner une violation',
        prefixIcon: Icon(Icons.warning_amber_rounded, color: Colors.redAccent),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        // contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      ),
      items: violations.map((violation) {
        return DropdownMenuItem<String>(
          value: violation,
          child: Text(violation),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedViolation = value;
        });
      },
    );
  }
}
