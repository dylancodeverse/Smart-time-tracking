import 'package:flutter/material.dart';
import 'package:sola/core/theme.dart';

class BusActions extends StatelessWidget {
  final bool isDepart;
  final VoidCallback onStartStop;
  final bool showParticipation;
  final VoidCallback? onParticipation;

  const BusActions({required this.isDepart, required this.onStartStop, required this.showParticipation, this.onParticipation});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.darkPrimary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            onPressed: onStartStop,
            child: Text(isDepart ? "Arrivée" : "Départ", style: TextStyle(color: AppTheme.scaff)),
          ),
        ),
        if (showParticipation) const SizedBox(width: 10),
        if (showParticipation)
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.darkPrimary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onPressed: onParticipation,
              child: Text("Participation", style: TextStyle(color: AppTheme.scaff)),
            ),
          ),
      ],
    );
  }
}
