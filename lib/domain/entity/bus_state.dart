import 'package:sola/domain/entity/assignement.dart';
import 'package:sola/domain/entity/check.dart';

class BusState {
  int id ;
  int statusCheck ;
  Check ? lastCheck;
  Assignment lastAssignment ;
  int? nextChangeDatePrevision;

  BusState({required this.id , required this.statusCheck , required this.lastAssignment, this.lastCheck, this.nextChangeDatePrevision});

}