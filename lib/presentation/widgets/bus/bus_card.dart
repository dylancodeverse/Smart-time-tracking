import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sola/core/theme.dart';
import 'package:sola/presentation/providers/active_bus_providers.dart';
import 'package:sola/presentation/widgets/bus/bus_actions.dart';
import 'package:sola/presentation/widgets/bus/bus_details.dart';
import 'package:sola/presentation/widgets/bus/bus_disable_option.dart';
import 'package:sola/presentation/widgets/bus/bus_info_header.dart';
import 'package:sola/presentation/widgets/utils/color_checker.dart';
class ActiveBusCard extends StatelessWidget {
  const ActiveBusCard({super.key});


  @override
  Widget build(BuildContext context) {
    final activeBus = context.watch<ActiveBusProvider>().activeBus; // ✅ Écoute uniquement CE bus

    final activeBusProvider = context.read<ActiveBusProvider>(); // 🔹 No rebuild ici

    print("Rendering BusCard: ${activeBus.bus.immatriculation}"); // 🔎 Debug ici

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
                BusInfoHeader(immatriculation: activeBus.bus.immatriculation, chauffeurNomPrenom:activeBus.bus.chauffeurNomPrenom),
                // supprimer option
                BusDisableOption(),
              ],
            ),
            const SizedBox(height: 10),
            BusDetails(
                        nombreTours: activeBus.getLibNombreTours(),
                        statut: activeBus.bus.libStatut,
                        statutColor: ColorLib.getColorByStatus(activeBus.bus.statut),
            ),

            const SizedBox(height: 10),

            BusActions(
              isDepart: activeBus.isDepart,
              onStartStop: () {
                activeBus.isDepart ? activeBusProvider.terminerTour() : activeBusProvider.demarrerTour();
              },
              showParticipation: activeBus.nombreTours >= 2,
              onParticipation: () {},
            ),

          ],
        ),
      ),
    );

  }
}
