import 'package:sola/data/implementation/sqflite/shared_preferences_datasource.dart';
import 'package:sola/domain/entity/update_cache/participation_count.dart';
import 'package:sola/domain/service/implementation/cache/participation_notpayed_count.dart';

class ParticipationCache{
  static ParticipationCountCache getParticipationCountRepositoryImplCache(){
    SharedPreferencesDataSource<ParticipationCount>lastUpdateDataSource = SharedPreferencesDataSource<ParticipationCount>(
        key: "participation_count_last_update",
        fromJson: ParticipationCount.fromJson,
        toJson: (update) => update.toJson(),
      );
    return ParticipationCountCache(dataSource: lastUpdateDataSource);
  }
}