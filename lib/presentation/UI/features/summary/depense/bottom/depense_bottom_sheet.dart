import 'package:flutter/material.dart';
import 'package:sola/presentation/UI/config/theme.dart';
import 'package:sola/presentation/UI/widgets/bottom_sheet/input_field.dart';
import 'package:sola/presentation/providers_services/depense/depense_service.dart';
import 'package:sola/presentation/providers_services/payment/payment.dart';
class DepenseBottomSheet extends StatefulWidget {
  final PaymentService paymentService;
  const DepenseBottomSheet({required this.paymentService});

  @override
  State<DepenseBottomSheet> createState() => _DepenseBottomSheetState();
}

class _DepenseBottomSheetState extends State<DepenseBottomSheet> {
  late TextEditingController _depense;
  late TextEditingController _comments;
  
  late PaymentService service ;
  @override
  void initState() {
    super.initState();
    _depense = TextEditingController();
    _comments= TextEditingController();
  }

  @override
  void dispose() {
    _depense.dispose();
    _comments.dispose();
    super.dispose();
  }

  void _validate() async{
    DepenseUIService depenseUIService = DepenseUIService();
    await depenseUIService.init(super.widget.paymentService);
    await depenseUIService.confirmDepense(int.parse(_depense.text) , _comments.text );
    Navigator.pop(context);
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
          "Déclaration de dépense",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.primaryColor),
        ),
        const SizedBox(height: 16),

        // Champs de texte réutilisables
        buildEditableInputField(
          icon: Icons.money,
          hint: "Dépense",
          controller: _depense,
          keyboardType: TextInputType.numberWithOptions(),
        ),
        const SizedBox(height: 12),
        buildEditableInputField(
          icon: Icons.comment,
          hint: "Commentaire",
          controller: _comments,
        ),

        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _validate,
          style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal,
          minimumSize: const Size(double.infinity, 48),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          ),
          child: const Text("Valider"),
        ),
        ],
      ),
      ),
    );
  }
}
