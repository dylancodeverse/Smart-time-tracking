import 'package:flutter/material.dart';
import 'package:sola/global/participation.dart';
import 'package:sola/presentation/UI/config/theme.dart';
import 'package:sola/presentation/UI/features/home/bus_card/participation_button.dart';
class BusActions extends StatelessWidget {
  final String isDepart;
  final VoidCallback onStartStop;
  final int participationState;
  final VoidCallback? onParticipation;

  const BusActions({
    super.key,
    required this.isDepart,
    required this.onStartStop,
    required this.participationState,
    this.onParticipation,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox( // ✅ Constraining the width to prevent layout errors
      width: double.infinity,
      child: Row(
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
              child: Text(isDepart, style: TextStyle(color: AppTheme.scaff)),
            ),
          ),

          if(participationState>ParticipationVar.noParticipation) const SizedBox(width: 10), // ✅ Prevents tight packing of elements

          if (participationState != ParticipationVar.noParticipation)
            Expanded(
              child: ParticipationButton(
                participationState: participationState,
                onParticipation: onParticipation!,
              ),
            ),
        ],
      ),
    );
  }
}
