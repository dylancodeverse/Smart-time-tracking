import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sola/lib/price_format.dart';
import 'package:sola/presentation/UI/config/theme.dart';
import 'package:sola/presentation/UI/features/summary/payment/bottom_sheet/edit_participation_bottom_list_sheet.dart';
import 'package:sola/presentation/providers_services/participation/participation_today.dart';
import 'package:sola/domain/entity/participation/today_participation.dart';

class ParticipationBottomList extends StatelessWidget {
  const ParticipationBottomList({super.key});

  @override
  Widget build(BuildContext context) {
    final participationService = Provider.of<ParticipationToday>(context, listen: false);
    context.watch<ParticipationToday>();

    Future<void> editParticipation(TodayParticipationLib p, int newMontant) async {
      final updated = p.copyWith(montant: newMontant);
      await participationService.updateParticipation(updated,context);
    }

    return DraggableScrollableSheet(
      expand: false,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.scaff,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: FutureBuilder<List<TodayParticipationLib>>(
            future: participationService.getAllTodayParticipation(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text("Erreur: ${snapshot.error}"));
              }

              final participations = snapshot.data ?? [];
              if (participations.isEmpty) {
                return const Center(child: Text("Aucune participation aujourd'hui."));
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHandle(),
                  Text(
                    "Les participations",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: participations.length,
                      itemBuilder: (context, index) {
                        final p = participations[index];
                        return MiniParticipationCard(
                          montant: p.montant,
                          immatriculation: p.immatriculation,
                          onEdit: (newMontant) async {
                            await editParticipation(p, newMontant);
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildHandle() {
    return Center(
      child: Container(
        width: 40,
        height: 4,
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

class MiniParticipationCard extends StatelessWidget {
  final int montant;
  final String immatriculation;
  final Future<void> Function(int) onEdit;

  const MiniParticipationCard({
    super.key,
    required this.montant,
    required this.immatriculation,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        leading: CircleAvatar(
          backgroundColor: AppTheme.scaff.withOpacity(0.1),
          child: Icon(Icons.money_rounded, color: AppTheme.primaryColor),
        ),
        title: Text(PriceFormat.formatAR(montant)),
        subtitle: Text(immatriculation, style: AppTheme.bodyMediu),
        trailing: IconButton(
          icon: Icon(Icons.edit, color: Colors.grey[400]),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              builder: (_) => EditParticipationBottomListSheet(
                montant: montant,
                immatriculation: immatriculation,
                onSave: onEdit,
              ),
            );
          },
        ),
      ),
    );
  }
}
