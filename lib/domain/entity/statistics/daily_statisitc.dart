import 'package:sola/domain/entity/bus_state.dart';

class DailyStatistic {
  int amount ;
  int round ;
  BusState busState ;

  DailyStatistic({required this.amount, required this.round, required this.busState});
} 