import 'package:sola/data/interface/datasource/datasource.dart';
import 'package:sola/domain/entity/assignement.dart';
import 'package:sola/domain/entity/bus_state.dart';
import 'package:sola/domain/entity/check.dart';
import 'package:sola/domain/service/interface/i_check_in.dart';
import 'package:sola/lib/date_helper.dart';

class CheckIn implements ICheckIn {

  DataSource<Check> dataSourceCheck ;
  DataSource<BusState> dataSourceBusState; 

  CheckIn({required this.dataSourceCheck  , required this.dataSourceBusState});


  @override
  Future<BusState> arrival(String assignementId,  int busStateId, int amount, int lastChecking) async{
    // init assignement
    Assignment assignment= Assignment(id: assignementId);
    // update check by id
    Check check=  Check(assignment: assignment, 
                        arrivalDate: Date.getTimestampNow(), amount: amount,id: lastChecking);

    await dataSourceCheck.update(check);

    // update status
    BusState busState = BusState(id: busStateId, statusCheck: 0, lastAssignment: assignment, lastCheck: null); 
    await dataSourceBusState.update(busState);

    return busState;

  }
  
}