import 'package:sola/data/config/sqfllite/sqflite_request.dart';
import 'package:sola/data/helper/sqflite/sqflite_database.dart';
import 'package:sola/data/implementation/sqflite/custom_sqllite_datasource.dart';
import 'package:sola/domain/entity/assignement.dart';
import 'package:sola/domain/entity/bus.dart';
import 'package:sola/domain/entity/bus_state.dart';
import 'package:sola/domain/entity/check.dart';
import 'package:sola/domain/entity/copilot.dart';
import 'package:sola/domain/entity/driver.dart';
import 'package:sola/domain/entity/statistics/daily_statisitc.dart';
import 'package:sola/domain/service/implementation/stats/daily_statistic_list_service.dart';

class InjectiondailystatisticList {


  static DailyStatistic fromMap(Map<String, dynamic> map) {
    return DailyStatistic(
      amount: map["total_montant"] ?? 0,
      round: map["nombre_tours"] ?? 0,
      busState: BusState(id: map['etat_pointage_id'], statusCheck: map['etat_pointage'],
          participationState: map['participation_etat'],
          nextChangeDatePrevision: map['estimation_prochaine_action'],
          lastAssignment: Assignment(
              id: map["affectation_id"].toString(),
              assignmentDate: DateTime.parse(map["affectation_date"]),
              bus: Bus(
                id: map["vehicule_id"].toString(),
                registrationNumber: map["immatriculation"],
                model: map["modele"],
                status: map["statut"] ?? 0,
              ),
              driver: Driver(
                id: map["chauffeur_id"].toString(),
                lastName: map["chauffeur_nom"],
                firstName: map["chauffeur_prenom"],
              ),
              copilot: Copilot(
                id: map["copilote_id"].toString(),
                lastName: map["copilote_nom"],
                firstName: map["copilote_prenom"],
              ),
            ),
            
      lastCheck: map["dernier_pointage"] != null
          ? Check(
              id: map["dernier_pointage"],
              assignment: Assignment(
                id: map["affectation_id"].toString(),
                assignmentDate: DateTime.parse(map["affectation_date"]),
                bus: Bus(
                  id: map["vehicule_id"].toString(),
                  registrationNumber: map["immatriculation"],
                  model: map["modele"],
                  status: map["statut"] ?? 0,
                ),
                driver: Driver(
                  id: map["chauffeur_id"].toString(),
                  lastName: map["chauffeur_nom"],
                  firstName: map["chauffeur_prenom"],
                ),
                copilot: Copilot(
                  id: map["copilote_id"].toString(),
                  lastName: map["copilote_nom"],
                  firstName: map["copilote_prenom"],
                ),
              ),
              arrivalDate: DateTime.now().millisecondsSinceEpoch, // Valeur par défaut
            )
          : null
        ),

          

    );
  }

  static Map<String,dynamic> toMap(DailyStatistic dailyStatistic){
  return {};
  }

  static Future<DailyStatisticListService> getStatsService() async{
    return  DailyStatisticListService(dataSource:
      CustomSqlliteDatasource<DailyStatistic>(database: await SqfliteDatabaseHelper().database, rawQuery:SqlfliteRequest.getTodayStats() , 
                              fromMap: fromMap)); 
  }
  static Future<DailyStatisticListService> getStatsQueueCadenceService() async{
    return DailyStatisticListService(dataSource:
      CustomSqlliteDatasource<DailyStatistic>(database: await SqfliteDatabaseHelper().database, rawQuery:SqlfliteRequest.getBusInQueueASC() , 
                              fromMap: fromMap)); 
  }

}