import 'package:flutter/material.dart';
import 'package:sola/core/theme.dart';

class BusDetails extends StatelessWidget {
  final String nombreTours;
  final String statut;
  final Color statutColor;

  const BusDetails({required this.nombreTours, required this.statut, required this.statutColor});

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
              Text(nombreTours, style: AppTheme.bodyMediu),
              Text(statut, style: TextStyle(color: statutColor, fontWeight: FontWeight.bold)),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
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
