import 'package:sola/application/injection_helper/cache/last_update_cache.dart';
import 'package:sola/application/injection_helper/cache/participation_cache.dart';
import 'package:sola/data/helper/sqflite/sqflite_database.dart';
import 'package:sola/data/implementation/bus_state_custom/bus_state_custom.dart';
import 'package:sola/domain/service/implementation/cache/last_update_repo.dart';
import 'package:sola/domain/service/implementation/denormalization/manual_update/denormalize_state.dart';
import 'package:sola/domain/service/implementation/denormalization/background_update/denormalize_state_auto.dart';

class BusStateCustomINJ {
  static Future<DenormalizeState> getBusStateCustomImpl() async{
    LastUpdateRepositoryImpl lastUpdateRepositoryImpl=  LastUpdateCache.getLastUpdateRepositoryImpl();
    BusStateCustomImpl busStateCustomImpl= BusStateCustomImpl(database: await SqfliteDatabaseHelper().database );
    return DenormalizeState (busStateCustom: busStateCustomImpl,lastUpdateRepository: lastUpdateRepositoryImpl
    ,participationCountCache:  ParticipationCache.getParticipationCountRepositoryImplCache() 
    );      
  }
  static Future<DenormalizeStateAuto> getBusStateCustomImplAUTO() async{
    return DenormalizeStateAuto ();
  }

}