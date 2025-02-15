import 'package:flutter/material.dart';
import 'package:sola/core/theme.dart';

class BusInfoHeader extends StatelessWidget {
  final String immatriculation;
  final String chauffeurNomPrenom;

  const BusInfoHeader({required this.immatriculation, required this.chauffeurNomPrenom});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey[200],
          child: Icon(Icons.bus_alert_sharp, color: AppTheme.primaryColor),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(immatriculation, style: AppTheme.bodyLarge),
            Text(chauffeurNomPrenom, style: AppTheme.bodyMediu),
          ],
        ),
      ],
    );
  }
}
