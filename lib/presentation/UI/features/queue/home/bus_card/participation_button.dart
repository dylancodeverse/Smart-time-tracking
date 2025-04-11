import 'package:flutter/material.dart';
import 'package:sola/global/participation.dart';
import 'package:sola/presentation/UI/config/theme.dart';

class ParticipationButton extends StatelessWidget {
  final int participationState;
  final VoidCallback onParticipation;

  const ParticipationButton({
    super.key,
    required this.participationState,
    required this.onParticipation,
  });

  @override
  Widget build(BuildContext context) {
    if (participationState == ParticipationVar.noParticipation) {
      return const SizedBox(); // ✅ Ne rien afficher si aucune participation
    }

    bool isParticipationEnabled = enableParticipation();

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isParticipationEnabled ? AppTheme.darkPrimary : Colors.grey[300],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
      onPressed: isParticipationEnabled ? onParticipation : null, // Désactive le bouton si déjà payé
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isParticipationEnabled ? Icons.hourglass_empty : Icons.check_circle,
            color: isParticipationEnabled ? AppTheme.scaff : Colors.green,
            size: 20,
          ),
          const SizedBox(width: 8), // Espacement entre l'icône et le texte
          Text(
            isParticipationEnabled ? "Participation" : "Payé",
            style: TextStyle(
              color: isParticipationEnabled ? AppTheme.scaff : Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  bool enableParticipation() {
    return participationState != ParticipationVar.okParticipation;
  }
}
