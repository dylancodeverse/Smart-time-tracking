import 'package:sola/application/entity_helper/complete_participation/complete_participation_helper.dart';
import 'package:sola/data/helper/sqflite/sqflite_database.dart';
import 'package:sola/data/implementation/sqflite/sqflite_datasource.dart';
import 'package:sola/data/interface/datasource/datasource.dart';
import 'package:sola/domain/entity/complete_participation/complete_participation.dart';
import 'package:sola/domain/service/implementation/complete_participation/complete_participation_service.dart';
import 'package:sola/domain/service/interface/complete_participation/i_complete_participation.dart';

class InjCompleteParticipation {
  static Future<DataSource<CompleteParticipation>> getCompleteParticipationDataSource() async {
    return SQLiteDataSource(
      database: await SqfliteDatabaseHelper().database,
      tableName: "participation_complete",
      fromMap: CompleteParticipationHelper.fromMap,
      toMap: CompleteParticipationHelper.toMap,
    );
  }

  static Future<ICompleteParticipationService> getCompleteParticipationInstance() async {
    return CompleteParticipationService(
      completeParticipationDataSource: await getCompleteParticipationDataSource(),
    );
  }
}
