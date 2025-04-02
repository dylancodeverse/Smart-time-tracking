import 'package:sola/application/injection_helper/cache/participation_cache.dart';
import 'package:sola/application/injection_helper/check/service_bus_state.dart';
import 'package:sola/application/injection_helper/violation/violation_checking_datasource.dart';
import 'package:sola/application/utils/map_utils.dart';
import 'package:sola/data/helper/sqflite/sqflite_database.dart';
import 'package:sola/data/implementation/sqflite/sqflite_datasource.dart';
import 'package:sola/data/interface/datasource/datasource.dart';
import 'package:sola/domain/entity/assignement.dart';
import 'package:sola/domain/entity/bus.dart';
import 'package:sola/domain/entity/bus_state.dart';
import 'package:sola/domain/entity/check.dart';
import 'package:sola/domain/entity/copilot.dart';
import 'package:sola/domain/entity/driver.dart';
import 'package:sola/domain/service/implementation/checking/check_in.dart';
import 'package:sola/domain/service/implementation/checking/check_out.dart';
import 'package:sola/domain/service/implementation/checking/prediction_duration.dart';
import 'package:sola/domain/service/implementation/violation/violation_checking_service.dart';
import 'package:sola/domain/service/interface/checking/i_check_in.dart';
import 'package:sola/domain/service/interface/checking/i_check_out.dart';

class ServiceCheck {
  static Map<String, dynamic> toMap(Check check) {
    return MapUtils.removeNulls({
      "id": check.id,
      "date_arrivee": check.arrivalDate,
      "date_depart": check.departureDate,
      "id_vehicule": check.assignment.bus?.id, // Vérifie si l'objet existe
      "id_affectation": check.assignment.id,
      "montant": check.amount,
      "commentaires": check.comments,
    });
  }
  static Check fromMap(Map<String, dynamic> map) {
  return Check(
    id: map["id"] as int?,
    arrivalDate: map["date_arrivee"] as int,
    assignment: Assignment(
      id: map["id_affectation"] as String?,
      assignmentDate: map["affectation_date"] != null
          ? DateTime.parse(map["affectation_date"])
          : null,
      bus: Bus(
        id: map["id_vehicule"] as String?,
        registrationNumber: map["immatriculation"] as String?,
        model: map["modele"] as String?,
        status: map["statut"] as int?,
      ),
      driver: Driver(
        id: map["chauffeur_id"] as String,
        lastName: map["chauffeur_nom"] as String? ?? "Nom inconnu",
        firstName: map["chauffeur_prenom"] as String? ?? "Prénom inconnu",
      ),
      copilot: Copilot(
        id: map["copilote_id"] as String,
        lastName: map["copilote_nom"] as String? ?? "Nom inconnu",
        firstName: map["copilote_prenom"] as String? ?? "Prénom inconnu",
      ),
    ),
  );
}


  static Future<ICheckOut> getCheckOutService() async{
    DataSource<Check> c= SQLiteDataSource(database:await SqfliteDatabaseHelper().database ,
         tableName:"pointages" , fromMap: fromMap, toMap: toMap);
    DataSource<BusState> bs = SQLiteDataSource(database: await SqfliteDatabaseHelper().database, tableName: 'etat_voitures_actu',
     fromMap: ServiceBusState.fromMap, toMap: ServiceBusState.toMap);

    return  CheckOut(checkDatasource:c ,busStateDatasource: bs ,iPredictionDuration: PredictionDuration(busState: bs));

  }

  static Future<ICheckIn> getCheckInService() async{
    DataSource<Check> c= SQLiteDataSource(database:await SqfliteDatabaseHelper().database ,
         tableName:"pointages" , fromMap: fromMap, toMap: toMap);
    DataSource<BusState> bs = SQLiteDataSource(database: await SqfliteDatabaseHelper().database, tableName: 'etat_voitures_actu',
     fromMap: ServiceBusState.fromMap, toMap: ServiceBusState.toMap);

    // prediction 
    DataSource<BusState> busStateDatasourcePrediction = SQLiteDataSource(database: await SqfliteDatabaseHelper().database, tableName: 'v_etat_voitures_actu',
     fromMap: ServiceBusState.fromMapPredictionModel, toMap: ServiceBusState.toMap);


     return CheckIn(dataSourceCheck: c, dataSourceBusState: bs ,iPredictionDuration: PredictionDuration(busState: busStateDatasourcePrediction)
          ,iViolationChecking: ViolationCheckingService(violationCheckingDatasource: await ViolationCheckingDatasource.getViolationCheckingDatasourceSQFLITE())
          ,participationCountServiceCache: ParticipationCache.getParticipationCountRepositoryImplCache()
     );
  }

  static Future<DataSource<BusState>> getBusStateDatasourceSimple()async{
    return  SQLiteDataSource(database: await SqfliteDatabaseHelper().database, tableName: 'etat_voitures_actu',
     fromMap: ServiceBusState.fromMap, toMap: ServiceBusState.toMap);
  }
}
