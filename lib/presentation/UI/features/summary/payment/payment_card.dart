
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sola/lib/price_format.dart';
import 'package:sola/presentation/UI/config/theme.dart';
import 'package:sola/presentation/UI/features/summary/payment/bottom_sheet/edit_bottom_sheet.dart';
import 'package:sola/presentation/UI/features/summary/payment/bottom_sheet/participation_bottom_list.dart';
import 'package:sola/presentation/UI/widgets/bottom_sheet/input_field.dart';
import 'package:sola/presentation/providers_services/payment/payment.dart';

class PaymentCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final service =Provider.of<PaymentService>(context);
    final paymentScreenModel = service.paymentScreenModel;
    final String reference = paymentScreenModel.getReferenceLabel();

    return FutureBuilder(
      future: service.initData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        return Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      reference,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.primaryColor),
                    ),
                    InkWell(
                      onTap: () => showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        builder: (_) => EditBottomSheet(),
                      ),
                      child: Icon(Icons.edit, color: Colors.black54),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  "${service.participants} participants",
                  style: TextStyle(fontSize: 12, color: const Color.fromARGB(225, 0, 0, 0)),
                ),
                SizedBox(height: 8),
                Text(
                  "${PriceFormat.formatAR(service.toSend as int) }",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      buildButton(Icons.payment, "Détails", AppTheme.darkPrimary , context, ParticipationBottomList()),
                      buildButton(
                        paymentScreenModel.paymentState.icon,
                        paymentScreenModel.paymentState.paymentState,
                        paymentScreenModel.paymentState.color, 
                        context,
                        EditBottomSheet()
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


}
