import 'package:sola/domain/service/interface/participation/i_participation.dart';
import 'package:sola/global/participation.dart';
import 'package:sola/presentation/model/stats/daily_statistic.dart';

class ParticipationService {
  static save(IParticipation iParticipation, DailyStatisticView dailyStatisticView , int montant , String comments) async{
    if (montant!= ParticipationVar.amount && comments.trim().isEmpty) {
      print("Error: Comments are required when montant is not 4000.");
      return ;
    }
    await iParticipation.saveParticipation(dailyStatisticView.busID, montant,comments);
  }  
}