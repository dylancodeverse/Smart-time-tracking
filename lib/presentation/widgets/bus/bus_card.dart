import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sola/core/theme.dart';
import 'package:sola/presentation/providers/active_bus_providers.dart';
import 'package:sola/presentation/widgets/utils/color_checker.dart';
class ActiveBusCard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final activeBus = context.watch<ActiveBusProvider>().activeBus; // ✅ Écoute uniquement CE bus

    print("carte rebuilt${activeBus.bus.immatriculation}");

    final activeBusProvider = context.read<ActiveBusProvider>(); // 🔹 No rebuild ici


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
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey[200],
                      child: Icon(Icons.bus_alert_sharp, color: AppTheme.primaryColor),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(activeBus.bus.immatriculation, style: AppTheme.bodyLarge),
                        Text(activeBus.bus.chauffeurNomPrenom, style: AppTheme.bodyMediu),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.scaff,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 4),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.cancel, color: const Color.fromARGB(255, 222, 52, 26), size: 16),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(activeBus.getLibNombreTours(), style: AppTheme.bodyMediu),
                      Text(activeBus.bus.libStatut, style: TextStyle(color: ColorLib.getColorByStatus(activeBus.bus.statut), fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(activeBus.getLibMontant(), style: AppTheme.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.flag, color: AppTheme.darkPrimary, size: 16),
                          const SizedBox(width: 10),                          
                          Text("14:30:34", style: AppTheme.bodyMediu),
                        ],
                      )

                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.darkPrimary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () {
                      activeBus.isDepart? activeBusProvider.terminerTour() :
                                          activeBusProvider.demarrerTour();
                    },
                    child: Text(activeBus.isDepart ? "Arrivée" : "Départ", style: TextStyle(color: AppTheme.scaff)),
                  ),
                ),
                // cette partie n'apparait que si Vehicule elligible a payer 
                if (activeBus.nombreTours >= 2) 
                const SizedBox(width: 10),
                if (activeBus.nombreTours >= 2)
                Expanded(

                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.darkPrimary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(vertical: 12),

                    ),
                    onPressed: () {},
                    child: Text("Participation", style: TextStyle(color: AppTheme.scaff)),
                  ),
                ),
                // jusque la
              ],              
            ),
          ],
        ),
      ),
    );

  }
}
