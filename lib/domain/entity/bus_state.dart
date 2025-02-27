import 'package:sola/domain/entity/assignement.dart';
import 'package:sola/domain/entity/check.dart';

class BusState {
  int id ;
  int ?statusCheck ;
  Check ? lastCheck;
  Assignment? lastAssignment ;
  int? nextChangeDatePrevision;
  int ? participationState;

  BusState({required this.id ,  this.statusCheck , this.lastAssignment, this.lastCheck, this.nextChangeDatePrevision, 
            this.participationState
            });

}