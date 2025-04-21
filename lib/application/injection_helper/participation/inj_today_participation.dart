import 'package:sola/application/entity_helper/participation/today_participation_helper.dart';
import 'package:sola/data/helper/sqflite/sqflite_database.dart';
import 'package:sola/data/implementation/sqflite/sqflite_datasource.dart';
import 'package:sola/data/interface/datasource/datasource.dart';
import 'package:sola/domain/entity/participation/today_participation.dart';
import 'package:sola/domain/service/implementation/participation/today_participation_lib_service.dart';
import 'package:sola/domain/service/interface/participation/i_today_participation_lib.dart';

class InjTodayParticipation {
  static Future<DataSource<TodayParticipationLib>> getTodayParticipationLibDatasource() async{
    return SQLiteDataSource(database: await SqfliteDatabaseHelper().database,
     tableName: "participation_du_jour_liste_lib", fromMap: TodayParticipationHelper.fromMap, toMap: TodayParticipationHelper.toMap);
  }

  static Future<ITodayParticipationLib> getTodayParticipationLibInstance() async{
    return TodayParticipationLibService(todayParticipationLibDatasource: await getTodayParticipationLibDatasource());
  }  
}