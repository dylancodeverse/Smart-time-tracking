import 'package:flutter/material.dart';
import 'package:sola/presentation/UI/config/theme.dart';
import 'package:sola/presentation/UI/features/queue/assignement/edit_assignement.dart';
import 'package:sola/presentation/providers_services/home/daily_statistic_provider.dart';

void showEditAssignementSheet(BuildContext context, DailyStatisticProvider activeBusProvider) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: _EditAssignementBottomSheetContent(provider: activeBusProvider),
      );
    },
  );
}
class _EditAssignementBottomSheetContent extends StatelessWidget {
  final DailyStatisticProvider provider;

  const _EditAssignementBottomSheetContent({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.scaff,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.horizontal_rule, size: 36, color: Colors.grey[500]),
            const SizedBox(height: 8),
            SimpleCardBUS(activeBusProvider: provider),
          ],
        ),
      ),
    );
  }
}

