import 'package:sola/data/interface/datasource/datasource.dart';
import 'package:sola/domain/entity/assignement.dart';
import 'package:sola/domain/entity/bus.dart';
import 'package:sola/domain/entity/bus_state.dart';
import 'package:sola/domain/entity/check.dart';
import 'package:sola/domain/service/interface/i_check_out.dart';
import 'package:sola/lib/date_helper.dart';

class CheckOut implements ICheckOut {
  DataSource<Check> checkDatasource;
  DataSource<BusState> busStateDatasource;

  CheckOut({required this.checkDatasource, required this.busStateDatasource});

  @override
  Future<int?> departure(String assignementId, String busId,int amount, int busStateId) async {
    // init Bus
    Bus bus = Bus(id: busId);
    // init assignement
    Assignment assignment= Assignment(id: assignementId,bus:bus );
    // rec check
    Check check=  Check(assignment: assignment, arrivalDate: Date.getTimestampNow());
    check.amount=amount;
    check.id= (await checkDatasource.insert(check) );

    // update status
    busStateDatasource.update(BusState(id: busStateId, statusCheck: 1, lastAssignment: assignment));

    return check.id;
  }
  
}