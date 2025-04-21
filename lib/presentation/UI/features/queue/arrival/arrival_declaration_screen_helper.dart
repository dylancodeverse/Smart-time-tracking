import 'package:flutter/material.dart';
import 'package:sola/presentation/UI/config/theme.dart';
import 'package:sola/presentation/UI/features/queue/arrival/arrival_declaration_screen.dart';
import 'package:sola/presentation/providers_services/home/daily_statistic_provider.dart';

void showArrivalDeclarationSheet(BuildContext context, DailyStatisticProvider monObjetProvider) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: _ArrivalBottomSheetContainer(monObjetProvider: monObjetProvider),
      );
    },
  );
}

class _ArrivalBottomSheetContainer extends StatelessWidget {
  final DailyStatisticProvider monObjetProvider;

  const _ArrivalBottomSheetContainer({required this.monObjetProvider});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.scaff,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Tu peux ajouter un bouton "fermer" ici si tu veux
              Icon(Icons.horizontal_rule, size: 40, color: Colors.grey[600]),

              // Ici on met le widget déjà existant
              SimpleCardBUS(
                activeBus: monObjetProvider.bus,
                dailyStatisticProvider: monObjetProvider,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

