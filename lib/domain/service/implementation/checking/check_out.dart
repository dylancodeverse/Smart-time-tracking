import 'package:sola/data/interface/datasource/datasource.dart';
import 'package:sola/domain/entity/assignement.dart';
import 'package:sola/domain/entity/bus.dart';
import 'package:sola/domain/entity/bus_state.dart';
import 'package:sola/domain/entity/check.dart';
import 'package:sola/domain/entity/nondispo/nondispochauffeur.dart';
import 'package:sola/domain/entity/statistics/daily_statisitc.dart';
import 'package:sola/domain/excpetion/check_exception.dart';
import 'package:sola/domain/service/implementation/stats/daily_statistic_list_service.dart';
import 'package:sola/domain/service/implementation/time_check_service/time_check_service.dart';
import 'package:sola/domain/service/interface/checking/i_check_out.dart';
import 'package:sola/domain/service/interface/checking/i_prediction_duration.dart';
import 'package:sola/domain/service/interface/nondispochauffeur/i_non_dispo_chauffeur.dart';
import 'package:sola/global/state_list.dart';
import 'package:sola/lib/date_helper.dart';

class CheckOut implements ICheckOut {
  DataSource<Check> checkDatasource;
  DataSource<BusState> busStateDatasource;
  DailyStatisticListService dailyStatisticListService;
  IPredictionDuration iPredictionDuration;
  INonDispoChauffeur nonDispoChauffeurService;

  CheckOut({required this.checkDatasource, required this.busStateDatasource, required this.iPredictionDuration , required this.dailyStatisticListService, required this.nonDispoChauffeurService});

  @override
  Future<BusState> departure(String assignementId, String busId, int busStateId, String pilotId) async {
    // verification
    if (!TimeCheckService.isWithinAllowedHours()) {
      throw Exception("Modification interdite en dehors des heures autorisées.");
    }
    await _canDoCheckOut(busId, pilotId);
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

  Future<bool> _canDoCheckOut(String busId, String pilotId) async{
    // jerena ny validite an'ny chauffeur
    List<NonDispoChauffeur> isNonDispo = await nonDispoChauffeurService.nonDispoListe(pilotId);
    if (isNonDispo.isNotEmpty) {
      IndispoException i = IndispoException();
      i.message = i.message+Date.dateFromMillis( isNonDispo[0].datefin);
      throw i ;
    }

    // liste en cadence ireto
    List< DailyStatistic> dailyStatistic = ( await dailyStatisticListService.getDailyStatistics()) ;
    if (dailyStatistic.isEmpty) {
      // zany hoe mbola vide lay en cadence donc surement afaka atao sortie lay bus
      return true ;
    }
    try {

      if (dailyStatistic[0].busState.lastAssignment?.bus?.id == busId){
        return true;
      }else{
        // raha tsy ilay bus no voalohany dia midika fa efa misy sortie natao teo aloha
        throw CadenceException();
      }
    } catch (e) {
      throw CadenceException();
    }
  }
  
}