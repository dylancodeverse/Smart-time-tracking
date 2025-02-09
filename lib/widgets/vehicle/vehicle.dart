import 'package:flutter/material.dart';
import 'package:spracheeasy/core/theme.dart';

class VehicleCard extends StatelessWidget {
  final String vehicleName;
  final String driver;
  final String status;
  final String fee;
  final double rating;

  const VehicleCard({
    super.key,
    required this.vehicleName,
    required this.driver,
    required this.status,
    required this.fee,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
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
                        Text(vehicleName, style: AppTheme.bodyLarge),
                        Text(driver, style: AppTheme.bodyMediu),
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
                      Text("Tours: 5", style: AppTheme.bodyMediu),
                      Text(status, style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(fee, style: AppTheme.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
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
                    onPressed: () {},
                    child: Text("Départ", style: TextStyle(color: AppTheme.scaff)),
                  ),
                ),
                // cette partie n'apparait que si Vehicule elligible a payer 
                const SizedBox(width: 10),
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
