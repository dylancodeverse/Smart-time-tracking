import 'package:sola/clean/domain/entity/assignement.dart';
import 'package:sola/clean/domain/entity/check.dart';

class DailyStatistic {
  Assignment assignment;
  int amount ;
  Check ? lastCheck ;

  DailyStatistic({required this.assignment,required this.amount, this.lastCheck});
} 