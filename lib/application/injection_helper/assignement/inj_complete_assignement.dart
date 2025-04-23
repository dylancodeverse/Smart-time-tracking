import 'package:sola/application/entity_helper/assignement/complete_assignement_helper.dart';
import 'package:sola/data/helper/sqflite/sqflite_database.dart';
import 'package:sola/data/implementation/sqflite/sqflite_datasource.dart';
import 'package:sola/data/interface/datasource/datasource.dart';
import 'package:sola/domain/entity/assignment/complete_assignement.dart';
import 'package:sola/domain/service/implementation/assignement/complete_assignement_service.dart';

class InjCompleteAssignement {
  static Future<DataSource<CompleteAssignment>> getCompleteAssignementDataSource() async{
    return SQLiteDataSource(database: await SqfliteDatabaseHelper().database, tableName: 
    "affectations_completes", fromMap: CompleteAssignmentHelper.fromMap, toMap: CompleteAssignmentHelper.toMap);
  } 
  static Future<DataSource<CompleteAssignment>> getCompleteAssignementDataSourceWithTableName() async{
    return SQLiteDataSource(database: await SqfliteDatabaseHelper().database, tableName: 
    "import_affectations_completes", fromMap: CompleteAssignmentHelper.fromMap, toMap: CompleteAssignmentHelper.toMap);
  }

  static Future<CompleteAssignementService> getCompleteAssignementServiceWithTableName() async{
    return CompleteAssignementService(assignementRepository: await getCompleteAssignementDataSourceWithTableName());
  }

  static Future<CompleteAssignementService> getCompleteAssignementService() async{
    return CompleteAssignementService(assignementRepository: await getCompleteAssignementDataSource());
  }
}