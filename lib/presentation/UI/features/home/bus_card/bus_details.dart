import 'package:flutter/material.dart';
import 'package:sola/presentation/UI/config/theme.dart';

class BusDetails extends StatelessWidget {
  final String round;
  final String status;
  final Color statusColor;
  final String libAmount;
  const BusDetails({required this.round, required this.status, required this.statusColor, required this.libAmount});

  @override
  Widget build(BuildContext context) {
    return Container(
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
              Text(round, style: AppTheme.bodyMediu),
              Text(status, style: TextStyle(color: statusColor, fontWeight: FontWeight.bold)),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(libAmount, style: AppTheme.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.flag, color: AppTheme.darkPrimary, size: 16),
                  const SizedBox(width: 10),
                  Text("14:30:34", style: AppTheme.bodyMediu),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
