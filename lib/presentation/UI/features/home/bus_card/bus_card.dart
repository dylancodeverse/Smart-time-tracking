import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sola/presentation/UI/config/color_checker.dart';
import 'package:sola/presentation/UI/config/theme.dart';
import 'package:sola/presentation/providers/home/daily_statistic_provider.dart';
import 'bus_actions.dart';
import 'bus_details.dart';
import 'bus_disable_option.dart';
import 'bus_info_header.dart';
class BusCard extends StatelessWidget {
  const BusCard({super.key});


  @override
  Widget build(BuildContext context) {
    final activeBus = context.watch<DailyStatisticProvider>().bus; // ✅ Écoute uniquement CE bus

    // final activeBusProvider = context.read<DailyStatisticProvider>(); // 🔹 No rebuild ici

    return Card(
      color: AppTheme.cardColor,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BusInfoHeader(pilotCompleteName:activeBus.driverCompleteName , registrationNumber: activeBus.registrationNumber,),
                // supprimer option
                BusDisableOption(),
              ],
            ),
            const SizedBox(height: 10),
            BusDetails(
                        libAmount: activeBus.getLibAmount(),
                        round: activeBus.getLibRound(),
                        status: activeBus.libStatus(),
                        statusColor: ColorLib.getColorByStatus(activeBus.status),
            ),

            const SizedBox(height: 10),

            BusActions(
              isDepart: activeBus.isDepart(),
              onStartStop: () {
                //  activeBusProvider.demarrerOuTerminerTour() ;
              },
              showParticipation: activeBus.participationActive(),
              onParticipation: () {},
            ),

          ],
        ),
      ),
    );

  }
}
