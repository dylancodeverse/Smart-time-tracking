import 'package:sola/data/interface/datasource/datasource.dart';
import 'package:sola/domain/entity/assignement.dart';
import 'package:sola/domain/entity/bus.dart';
import 'package:sola/domain/entity/bus_state.dart';
import 'package:sola/domain/entity/check.dart';
import 'package:sola/domain/entity/violation/violation.dart';
import 'package:sola/domain/entity/violation/violation_checking.dart';
import 'package:sola/domain/service/interface/checking/i_check_in.dart';
import 'package:sola/domain/service/interface/checking/i_prediction_duration.dart';
import 'package:sola/domain/service/interface/violation/i_violation_checking.dart';
import 'package:sola/global/participation.dart';
import 'package:sola/global/round.dart';
import 'package:sola/global/state_list.dart';
import 'package:sola/lib/date_helper.dart';

class CheckIn implements ICheckIn {

  DataSource<Check> dataSourceCheck ;
  DataSource<BusState> dataSourceBusState; 
  IPredictionDuration iPredictionDuration ;
  IViolationChecking iViolationChecking ;

  CheckIn({required this.dataSourceCheck  , required this.dataSourceBusState, required this.iPredictionDuration, required this.iViolationChecking});


  @override
  Future<BusState> arrival(String assignementId, String busId, int busStateId, int amount, int lastChecking, int currentRound) async{
    // init Bus
    Bus bus = Bus(id: busId);
    // init assignement
    Assignment assignment= Assignment(id: assignementId,bus:bus );
    // update check by id
    Check check=  Check(assignment: assignment, 
                        arrivalDate: Date.getTimestampNow(), amount: amount,id: lastChecking);

    await dataSourceCheck.update(check);

    return arrivalStateUpdate(busStateId, assignment, check, currentRound);
  }

  Future<BusState> arrivalStateUpdate(int busStateId, Assignment lastAssignment, Check lastCheck,int currentRound) async{
    // getPrediction
    int predictionArrival= await iPredictionDuration.getDepartureEstimation();

    // update status
    BusState busState = BusState(id: busStateId, statusCheck: StateList.enableArrivalDeclaration, lastAssignment: lastAssignment, lastCheck: lastCheck, nextChangeDatePrevision: predictionArrival); 
    
    if (currentRound+1==  RoundVar.roundStartParticipation) {
      busState.participationState = ParticipationVar.showParticipation;      
    }else{
      busState.participationState=ParticipationVar.noParticipation;
    }
    await dataSourceBusState.update(busState);
    return busState;
  }
  
  @override
  Future<void> arrivalUpdate(String assignementId, String busId, int busStateId, int amount, int lastChecking, String comments, List<Violation> listViolation  ) async{
    // init Bus
    Bus bus = Bus(id: busId);
    // init assignement
    Assignment assignment= Assignment(id: assignementId,bus:bus );
    // update check by id
    Check check=  Check(assignment: assignment, amount: amount,id: lastChecking, comments: comments);

    await dataSourceCheck.updateAndIgnoreNullColumns(check);
    // update state
    BusState busState = BusState(id: busStateId, statusCheck: StateList.enableDeparture);
    await dataSourceBusState.updateAndIgnoreNullColumns(busState);

    // insert violation
    List<ViolationChecking> list =[];
    for (Violation element in listViolation) {
      list.add(ViolationChecking(violationId: element.id!, checkId: check.id!));
    }
    iViolationChecking.saveViolationChecking(list);

    print("OKEY ");
  }
  
}