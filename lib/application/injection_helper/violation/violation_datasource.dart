import 'package:sola/application/entity_helper/violation/violation_helper.dart';
import 'package:sola/data/helper/sqflite/sqflite_database.dart';
import 'package:sola/data/implementation/sqflite/sqflite_datasource.dart';
import 'package:sola/data/interface/datasource/datasource.dart';
import 'package:sola/domain/entity/violation/violation.dart';
import 'package:sola/domain/service/implementation/violation/violation_service.dart';

class ViolationDatasource {
  static Future<DataSource<Violation>> getViolationDatasourceSQFLITE() async{
    return SQLiteDataSource(database: await SqfliteDatabaseHelper().database, tableName: "violation", fromMap: ViolationHelper.fromMap, toMap: ViolationHelper.toMap);
  }
  static Future<ViolationService> getViolationService() async{
    return ViolationService(violationDatasource: await getViolationDatasourceSQFLITE());
  }

  static Future<DataSource<Violation>> getViolationDatasourceSQFLITEIMPORT() async{
    return SQLiteDataSource(database: await SqfliteDatabaseHelper().database, tableName: "import_violation", fromMap: ViolationHelper.fromMapIMPORT, toMap: ViolationHelper.toMapSqlIMPORT);
  }
  static Future<ViolationService> getViolationServiceIMPORT() async{
    return ViolationService(violationDatasource: await getViolationDatasourceSQFLITEIMPORT());
  }

}