import 'package:flutter/material.dart';
import 'package:sola/global/participation.dart';
import 'package:sola/presentation/UI/config/color_checker.dart';
import 'package:sola/presentation/UI/config/theme.dart';
import 'package:sola/presentation/UI/features/queue/home/bus_card/bus_details.dart';
import 'package:sola/presentation/UI/features/queue/home/bus_card/bus_info_header.dart';
import 'package:sola/presentation/UI/widgets/bottomnav.dart';
import 'package:sola/presentation/UI/widgets/input_field.dart';
import 'package:sola/presentation/model/stats/daily_statistic.dart';
import 'package:sola/presentation/providers_services/home/daily_statistic_provider.dart';
class ParticipationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final monObjet = ModalRoute.of(context)!.settings.arguments as DailyStatisticProvider;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(AppTheme.appName),
        scrolledUnderElevation: 0,
      ),
      body: SimpleCardBUS(activeBus: monObjet.bus,superProvider: monObjet,), 

      bottomNavigationBar: Bottomnav(currentIndex: 0,),
    );

  }
  
}

class SimpleCardBUS extends StatefulWidget {
  final DailyStatisticView activeBus;
  final DailyStatisticProvider superProvider;

  const SimpleCardBUS({super.key, required this.activeBus, required this.superProvider});

  @override
  _SimpleCardBUSState createState() => _SimpleCardBUSState();
}

class _SimpleCardBUSState extends State<SimpleCardBUS> {
  
  final TextEditingController _amountController =  TextEditingController(text: ParticipationVar.amount.toString());
  final TextEditingController _commentController = TextEditingController(); 

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
                InputField(
                  controller: _amountController,
                  hintText: "Saisir le montant",
                  icon: Icons.attach_money,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10),

                // Champ de saisie pour les commentaires
                InputField(
                  controller: _commentController,
                  hintText: "Ajouter un commentaire",
                  icon: Icons.comment,
                  maxLines: 3,
                ),
                const SizedBox(height: 10),

                // Bouton de validation
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      widget.superProvider.updateParticipation(context,_amountController.text, _commentController.text);
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

}