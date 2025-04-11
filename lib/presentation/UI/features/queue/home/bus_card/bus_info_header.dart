import 'package:flutter/material.dart';
import 'package:sola/presentation/UI/config/theme.dart';

class BusInfoHeader extends StatelessWidget {
  final String registrationNumber;
  final String pilotCompleteName;

  const BusInfoHeader({required this.registrationNumber, required this.pilotCompleteName});

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
            Text(registrationNumber, style: AppTheme.bodyLarge),
            Text(pilotCompleteName, style: AppTheme.bodyMediu),
          ],
        ),
      ],
    );
  }
}
