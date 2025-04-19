import 'package:sola/application/entity_helper/participation/stats_participation_with_depense_helper.dart';
import 'package:sola/data/helper/sqflite/sqflite_database.dart';
import 'package:sola/data/implementation/sqflite/sqflite_datasource.dart';
import 'package:sola/data/interface/datasource/datasource.dart';
import 'package:sola/domain/entity/participation/stats_participation_with_depense.dart';
import 'package:sola/domain/service/implementation/participation/stats_participation_with_depense_service.dart';
import 'package:sola/domain/service/interface/participation/i_stats_participation_with_depense.dart';

class InjStatsParticipationWithDepense {
  static Future<DataSource<StatsParticipationWithDepense>> getStatsParticipationWithDepenseDatasource() async{
    return SQLiteDataSource(database: await SqfliteDatabaseHelper().database,
     tableName: "statsparticipationavecdepensedujour", fromMap: StatsParticipationWithDepenseHelper.fromMap, toMap: StatsParticipationWithDepenseHelper.toMap);
  }

  static Future<IStatsParticipationWithDepense> getStatsParticipationWithDepenseService() async{
    return StatsParticipationWithDepenseService(statsParticipationWithDepenseDatasource: await getStatsParticipationWithDepenseDatasource());
  }
}