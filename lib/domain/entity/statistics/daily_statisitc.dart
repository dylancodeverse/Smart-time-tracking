import 'package:sola/domain/entity/assignement.dart';
import 'package:sola/domain/entity/check.dart';

class DailyStatistic {
  Assignment assignment;
  int amount ;
  int round ;
  int statusCheck;
  Check ? lastCheck ;

  DailyStatistic({required this.assignment,required this.amount, this.lastCheck, required this.round, required this.statusCheck});
} 