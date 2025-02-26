import 'package:sola/application/entity_helper/violation/violation_checking_helper.dart';
import 'package:sola/data/helper/sqflite/sqflite_database.dart';
import 'package:sola/data/implementation/sqflite/sqflite_datasource.dart';
import 'package:sola/data/interface/datasource/datasource.dart';
import 'package:sola/domain/entity/violation/violation_checking.dart';

class ViolationCheckingDatasource {
  static Future<DataSource<ViolationChecking>> getViolationCheckingDatasourceSQFLITE() async{
    return SQLiteDataSource(database: await SqfliteDatabaseHelper().database, tableName: "violationparpointage", fromMap: ViolationCheckingHelper.fromMap, toMap: ViolationCheckingHelper.toMap);
  }  
}