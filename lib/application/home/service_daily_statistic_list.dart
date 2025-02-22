import 'package:sola/data/config/sqfllite/sqflite_request.dart';
import 'package:sola/data/helper/sqflite/sqflite_database.dart';
import 'package:sola/data/implementation/sqflite/custom_sqllite_datasource.dart';
import 'package:sola/domain/entity/assignement.dart';
import 'package:sola/domain/entity/bus.dart';
import 'package:sola/domain/entity/check.dart';
import 'package:sola/domain/entity/copilot.dart';
import 'package:sola/domain/entity/driver.dart';
import 'package:sola/domain/entity/statistics/daily_statisitc.dart';
import 'package:sola/domain/service/implementation/daily_statistic_list_service.dart';

class InjectiondailystatisticList {


  static DailyStatistic fromMap(Map<String, dynamic> map) {
    return DailyStatistic(
      amount: map["total_montant"] ?? 0,
      round: map["nombre_tours"] ?? 0,
      statusCheck: map["etat_pointage"] ?? 0,
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
          : null,
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
    );
  }

  static Future<DailyStatisticListService> getStatsService() async{
    return  DailyStatisticListService(dataSource:
      CustomSqlliteDatasource<DailyStatistic>(database: await SqfliteDatabaseHelper().database, rawQuery:SqlfliteRequest.getTodayStats() , 
                              fromMap: fromMap)); 
  }
}