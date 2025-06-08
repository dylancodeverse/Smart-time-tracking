import 'package:flutter/widgets.dart';
import 'package:sola/domain/service/interface/cache/i_participation_notpayed_count.dart';
import 'package:sola/domain/service/interface/participation/i_payment_participation_process_service.dart';
import 'package:sola/domain/service/interface/participation/i_stats_participation_with_depense.dart';
import 'package:sola/lib/reference_helper.dart';
import 'package:sola/presentation/model/payment/payment_screen_model.dart';

class PaymentService extends ChangeNotifier {
  IPaymentParticipationProcessService iPaymentParticipationProcessService;
  PaymentScreenModel paymentScreenModel;
  IStatsParticipationWithDepense iStatsParticipationWithDepense;
  IParticipationCountCache participationCountServiceCache;

  int? depense;
  int? participation;
  int? toSend ;
  int? countTotal;


  String? participants ;
  int? participantsCount;

  bool isLoaded = false;

  PaymentService({
    required this.iPaymentParticipationProcessService,
    required reference,
    required this.iStatsParticipationWithDepense,
    required this.participationCountServiceCache,
  }) : paymentScreenModel = PaymentScreenModel(reference: reference);

  void setReference(String newRef) async{
    ReferenceHelper.validateRef(newRef);
    await iPaymentParticipationProcessService.updatePayment(newRef);
    paymentScreenModel.setReference(newRef);
    notifyListeners();
  }

  Future<void> initData() async {
    if (isLoaded) return; // éviter de recharger plusieurs fois
    refreshData();
  }

  Future<void> refreshData() async {
    isLoaded = false; // on réinitialise d’abord le flag

    final stats = await iStatsParticipationWithDepense.getTodayStats();
    depense = stats.depense;
    participation = stats.montantParticipation;
    toSend = (participation as int) - (depense as int);

    int remainder = await participationCountServiceCache.getCount();

    countTotal = stats.count;
    participants = "$countTotal/${remainder + (countTotal as int)}";

    isLoaded = true; // on remet à jour
    notifyListeners(); // on notifie l’UI
  }


}
