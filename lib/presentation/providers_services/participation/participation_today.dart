import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sola/domain/entity/participation/participation.dart';
import 'package:sola/domain/entity/participation/today_participation.dart';
import 'package:sola/domain/service/interface/participation/i_participation.dart';
import 'package:sola/domain/service/interface/participation/i_today_participation_lib.dart';
import 'package:sola/presentation/providers_services/payment/payment.dart';

class ParticipationToday extends ChangeNotifier {
  ITodayParticipationLib participationTodayService;
  IParticipation participationService;

  ParticipationToday({
    required this.participationTodayService,
    required this.participationService,
  });

  Future<List<TodayParticipationLib>> getAllTodayParticipation() async {
    return await participationTodayService.getTodayParticipationsLib();
  }

  Future<void> updateParticipation(TodayParticipationLib participation,BuildContext context) async {
    await participationService.update(Participation(id: participation.id,busId: participation.idVehicule, participationDate: participation.participationDate, amount: participation.montant, superParticipation: null));
    await Provider.of<PaymentService>(context, listen: false).refreshData();
    notifyListeners();
  }
}