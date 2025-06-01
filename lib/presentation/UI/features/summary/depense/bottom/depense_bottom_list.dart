import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sola/domain/entity/depense/depense.dart';
import 'package:sola/lib/price_format.dart';
import 'package:sola/presentation/UI/config/theme.dart';
import 'package:sola/presentation/UI/features/summary/depense/bottom/edit_depense.dart';
import 'package:sola/presentation/providers_services/depense/depense_today.dart';

class DepenseBottomList extends StatelessWidget {
  const DepenseBottomList({super.key});

  @override
  Widget build(BuildContext context) {
    final depenseService = Provider.of<DepenseToday>(context, listen: false);
    context.watch<DepenseToday>();
    Future<void> editDepense(Depense depense) async {
      await depenseService.updateDepense(depense,context);
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
          child: FutureBuilder<List<Depense>>(
            future: depenseService.getAllTodayDepense(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text("Erreur: ${snapshot.error}"));
              }

              final depenses = snapshot.data ?? [];
              if (depenses.isEmpty) {
                  return const Center(child: Text("Aucune dépense aujourd'hui."));
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHandle(),
                  Text(
                    "Les dépenses",
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
                      itemCount: depenses.length,
                      itemBuilder: (context, index) {
                        final dep = depenses[index];
                        return MiniDepenseCard(
                          montant: dep.amount,
                          motif: dep.reason ?? '',
                          onEdit: (newMontant, newMotif) async {
                            await editDepense(Depense( id: dep.id,amount: newMontant,reason: newMotif ))  ;

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

class MiniDepenseCard extends StatelessWidget {
  final int? montant;
  final String motif;
  final Future<void> Function(int?, String) onEdit;

  const MiniDepenseCard({
    super.key,
    required this.montant,
    required this.motif,
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
        subtitle: Text(motif, style: AppTheme.bodyMediu),
        trailing: IconButton(
          icon: Icon(Icons.edit, color: Colors.grey[400]),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              builder: (_) => EditDepenseSheet(
                montant: montant,
                motif: motif,
                onSave: onEdit,
              ),
            );
          },
        ),
      ),
    );
  }
}
