import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sola/presentation/UI/widgets/bottom_sheet/input_field.dart';
import 'package:sola/presentation/providers/payment/payment.dart';

class EditBottomSheet extends StatefulWidget {
  @override
  State<EditBottomSheet> createState() => _EditBottomSheetState();
}

class _EditBottomSheetState extends State<EditBottomSheet> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    final ref = context.read<PaymentService>().reference;
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
    return DraggableScrollableSheet(
      expand: false,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                Center(
                  child: Container(
                    width: 50,
                    height: 5,
                    margin: EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                // Tabs
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    buildTab("Payement", true),
                  ],
                ),
                SizedBox(height: 16),

                // Static fields
                buildInputField(Icons.money, "A envoyer: 40,000 AR"),
                SizedBox(height: 12),
                buildInputField(Icons.money_off, "Dépense: 8,000 AR"),
                SizedBox(height: 12),
                buildInputField(Icons.person, "16 Participants"),
                SizedBox(height: 12),

                // Editable
                buildEditableInputField(
                  icon: Icons.key,
                  hint: "Référence",
                  controller: _controller,
                ),

                SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: _validate,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                      child: Text("Valider"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
