import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sola/lib/price_format.dart';
import 'package:sola/presentation/UI/config/theme.dart';
import 'package:sola/presentation/UI/widgets/bottom_sheet/input_field.dart';
import 'package:sola/presentation/providers_services/payment/payment.dart';

class EditBottomSheet extends StatefulWidget {
  @override
  State<EditBottomSheet> createState() => _EditBottomSheetState();
}

class _EditBottomSheetState extends State<EditBottomSheet> {
  late TextEditingController _controller;
  late PaymentService service ;
  @override
  void initState() {
    super.initState();
    service =  context.read<PaymentService>();
    final ref =service.paymentScreenModel.getReference();
    _controller = TextEditingController(text: ref);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _validate() {
    context.read<PaymentService>().setReference(_controller.text);
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
              "Modifier les informations",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: AppTheme.primaryColor),
            ),
            const SizedBox(height: 16),

            // Static fields
            buildInputField(
              Icons.money,
              "A envoyer: ${PriceFormat.formatAR(service.toSend as int)}",
            ),
            const SizedBox(height: 12),
            buildInputField(
              Icons.money_off,
              "Dépense: ${PriceFormat.formatAR(service.depense as int)}",
            ),
            const SizedBox(height: 12),
            buildInputField(
              Icons.person,
              "${service.countTotal} Participants",
            ),
            const SizedBox(height: 12),

            // Editable
            buildEditableInputField(
              icon: Icons.key,
              hint: "Référence",
              controller: _controller,
              keyboardType: TextInputType.number
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
