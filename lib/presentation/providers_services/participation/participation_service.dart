import 'package:sola/domain/service/interface/participation/i_participation.dart';
import 'package:sola/lib/price_format.dart';
import 'package:sola/presentation/model/stats/daily_statistic.dart';
import 'package:sola/presentation/providers_services/payment/payment.dart';

class ParticipationService {
  static save(IParticipation iParticipation, DailyStatisticView dailyStatisticView , String montant , String comments, PaymentService paymentService) async{
    int price= PriceFormat.getPrice(montant,2000,4000);
    await iParticipation.saveParticipation(dailyStatisticView.busID, price,comments,dailyStatisticView.busStateId);
    paymentService.refreshData();
  }  
}