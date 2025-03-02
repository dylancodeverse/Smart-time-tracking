import 'package:sola/application/entity_helper/assignement/assignement_helper.dart';
import 'package:sola/data/config/sqfllite/sqflite_request.dart';
import 'package:sola/data/helper/sqflite/sqflite_database.dart';
import 'package:sola/data/implementation/sqflite/custom_sqllite_datasource.dart';
import 'package:sola/data/interface/datasource/datasource.dart';
import 'package:sola/domain/entity/assignement.dart';
import 'package:sola/domain/service/implementation/assignement/assignement_service.dart';
import 'package:sola/domain/service/interface/assignement/i_assignement.dart';

class AssignementDatasource {
  static Future<DataSource<Assignment>> getAssignementDatasourceCustomSqlliteDatasource(String busId) async{
    return CustomSqlliteDatasource(database: await SqfliteDatabaseHelper().database, rawQuery: SqlfliteRequest.getCompleteASsignementByBusId(busId), fromMap: AssignementHelper.fromMap);
  }    

  static Future<IAssignement> getIAssignement(String busID) async{
    return AssignementService(assignementDatasource: await getAssignementDatasourceCustomSqlliteDatasource(busID));
  }
}