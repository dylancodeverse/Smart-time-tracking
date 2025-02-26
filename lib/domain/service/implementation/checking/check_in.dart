import 'package:sola/data/interface/datasource/datasource.dart';
import 'package:sola/domain/entity/assignement.dart';
import 'package:sola/domain/entity/bus.dart';
import 'package:sola/domain/entity/bus_state.dart';
import 'package:sola/domain/entity/check.dart';
import 'package:sola/domain/service/interface/checking/i_check_in.dart';
import 'package:sola/domain/service/interface/checking/i_prediction_duration.dart';
import 'package:sola/global/state_list.dart';
import 'package:sola/lib/date_helper.dart';

class CheckIn implements ICheckIn {

  DataSource<Check> dataSourceCheck ;
  DataSource<BusState> dataSourceBusState; 
  IPredictionDuration iPredictionDuration ;

  CheckIn({required this.dataSourceCheck  , required this.dataSourceBusState, required this.iPredictionDuration, });


  @override
  Future<BusState> arrival(String assignementId, String busId, int busStateId, int amount, int lastChecking) async{
    // init Bus
    Bus bus = Bus(id: busId);
    // init assignement
    Assignment assignment= Assignment(id: assignementId,bus:bus );
    // update check by id
    Check check=  Check(assignment: assignment, 
                        arrivalDate: Date.getTimestampNow(), amount: amount,id: lastChecking);

    await dataSourceCheck.update(check);

    // getPrediction
    int predictionArrival= await iPredictionDuration.getDepartureEstimation();

    // update status
    BusState busState = BusState(id: busStateId, statusCheck: StateList.enableArrivalDeclaration, lastAssignment: assignment, lastCheck: check, nextChangeDatePrevision: predictionArrival); 
    await dataSourceBusState.update(busState);

    return busState;

  }
  
  @override
  Future<void> arrivalUpdate(String assignementId, String busId, int busStateId, int amount, int lastChecking, String comments ) async{
    // init Bus
    Bus bus = Bus(id: busId);
    // init assignement
    Assignment assignment= Assignment(id: assignementId,bus:bus );
    // update check by id
    Check check=  Check(assignment: assignment, amount: amount,id: lastChecking, comments: comments);

    await dataSourceCheck.updateAndIgnoreNullColumns(check);

    BusState busState = BusState(id: busStateId, statusCheck: StateList.enableDeparture);
    await dataSourceBusState.updateAndIgnoreNullColumns(busState);
  }
  
}