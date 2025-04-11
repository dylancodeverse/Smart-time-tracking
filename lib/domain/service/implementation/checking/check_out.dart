import 'package:sola/data/interface/datasource/datasource.dart';
import 'package:sola/domain/entity/assignement.dart';
import 'package:sola/domain/entity/bus.dart';
import 'package:sola/domain/entity/bus_state.dart';
import 'package:sola/domain/entity/check.dart';
import 'package:sola/domain/entity/statistics/daily_statisitc.dart';
import 'package:sola/domain/service/implementation/stats/daily_statistic_list_service.dart';
import 'package:sola/domain/service/interface/checking/i_check_out.dart';
import 'package:sola/domain/service/interface/checking/i_prediction_duration.dart';
import 'package:sola/global/state_list.dart';
import 'package:sola/lib/date_helper.dart';

class CheckOut implements ICheckOut {
  DataSource<Check> checkDatasource;
  DataSource<BusState> busStateDatasource;
  DailyStatisticListService dailyStatisticListService;
  IPredictionDuration iPredictionDuration;

  CheckOut({required this.checkDatasource, required this.busStateDatasource, required this.iPredictionDuration , required this.dailyStatisticListService});

  @override
  Future<BusState> departure(String assignementId, String busId, int busStateId) async {
    // verification
    if (! await canDoCheckOut(busId)) throw Exception("Doit respecter la cadence");
    // init Bus
    Bus bus = Bus(id: busId);
    // init assignement
    Assignment assignment= Assignment(id: assignementId,bus:bus );
    // recording check
    Check check=  Check(assignment: assignment, departureDate: Date.getTimestampNow());
    check.id= (await checkDatasource.insert(check) );

    // getPrediction
    int predictionArrival= iPredictionDuration.getArrivalPrediction(check.departureDate as int);

    // update status
    BusState busState = BusState(id: busStateId, statusCheck: StateList.enableArrival, lastAssignment: assignment, lastCheck: check,nextChangeDatePrevision: predictionArrival);
    await busStateDatasource.updateAndIgnoreNullColumns(busState);

    return busState;
  }

  Future<bool> canDoCheckOut(String busId) async{
    // liste en cadence ireto
    List< DailyStatistic> dailyStatistic = ( await dailyStatisticListService.getDailyStatistics()) ;
    if (dailyStatistic.isEmpty) {
      // zany hoe mbola vide lay en cadence donc surement afaka atao sortie lay bus
      return true ;
    }
    try {

      return dailyStatistic[0].busState.lastAssignment?.bus?.id == busId;
    } catch (e) {
      return false;    
    }
  }
  
}