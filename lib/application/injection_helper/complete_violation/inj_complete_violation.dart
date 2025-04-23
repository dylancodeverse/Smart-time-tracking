import 'package:sola/application/entity_helper/complete_violation/complete_violation_helper.dart';
import 'package:sola/data/helper/sqflite/sqflite_database.dart';
import 'package:sola/data/implementation/sqflite/sqflite_datasource.dart';
import 'package:sola/data/interface/datasource/datasource.dart';
import 'package:sola/domain/entity/complete_violation/complete_violation.dart';
import 'package:sola/domain/service/implementation/complete_violation/complete_violation_service.dart';
import 'package:sola/domain/service/interface/complete_violation/i_complete_violation.dart';

class InjCompleteViolation {
  static Future<DataSource<CompleteViolation>> getCompleteViolationDataSource() async {
    return SQLiteDataSource(
      database: await SqfliteDatabaseHelper().database,
      tableName: "violations_des_pointages_complets",
      fromMap: CompleteViolationHelper.fromMap,
      toMap: CompleteViolationHelper.toMap,
    );
  }

  static Future<ICompleteViolationService> getCompleteViolationInstance() async {
    return CompleteViolationService(
      completeViolationDataSource: await getCompleteViolationDataSource(),
    );
  }
}
