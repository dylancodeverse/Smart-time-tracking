import 'package:sola/application/check/service_check.dart';
import 'package:sola/application/entity_helper/participation/participation_helper.dart';
import 'package:sola/data/helper/sqflite/sqflite_database.dart';
import 'package:sola/data/implementation/sqflite/sqflite_datasource.dart';
import 'package:sola/data/interface/datasource/datasource.dart';
import 'package:sola/domain/entity/participation/participation.dart';
import 'package:sola/domain/service/interface/participation/i_participation.dart';
import 'package:sola/domain/service/implementation/participation/participation_service.dart';

class ServiceINJParticipation {
  
  static Future<DataSource<Participation>> getParticipationDatasourceSQFLITE() async{
    return SQLiteDataSource(database: await SqfliteDatabaseHelper().database, tableName: "participation", fromMap: ParticipationHelper.fromMap, toMap: ParticipationHelper.toMap);
  }  

  static Future<IParticipation> getIParticipationInstance() async {
    return ParticipationRepository(participationDatasource:await getParticipationDatasourceSQFLITE(), busStateDatasource: await ServiceCheck.getBusStateDatasourceSimple());
  }

}