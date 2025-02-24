import 'package:sola/domain/service/interface/i_check_in.dart';
import 'package:sola/presentation/model/daily_statistic.dart';

class ArrivalDeclaration {

  final ICheckIn checkIn ;

  ArrivalDeclaration({required this.checkIn});

  void declaration(DailyStatisticView daily, String amount, String comments){

  }
}