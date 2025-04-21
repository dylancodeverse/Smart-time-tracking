import 'package:sola/domain/service/interface/participation/i_participation.dart';
import 'package:sola/presentation/model/stats/daily_statistic.dart';
import 'package:sola/presentation/providers_services/payment/payment.dart';

class ParticipationService {
  static save(IParticipation iParticipation, DailyStatisticView dailyStatisticView , int montant , String comments, PaymentService paymentService) async{
    await iParticipation.saveParticipation(dailyStatisticView.busID, montant,comments,dailyStatisticView.busStateId);
    paymentService.refreshData();
  }  
}