import 'package:sola/data/helper/sharedpreferences/database_reinit.dart';
import 'package:sola/data/implementation/cache/get_storage_datasource.dart';
import 'package:sola/domain/entity/update_cache/participation_count.dart';
import 'package:sola/domain/service/implementation/cache/participation_notpayed_count.dart';

class ParticipationCache{
  static ParticipationCountCache getParticipationCountRepositoryImplCache(){
    GetStorageDataSource<ParticipationCount>lastUpdateDataSource = GetStorageDataSource<ParticipationCount>(
        collectionKey: "participation_count_last_update",
        fromJson: ParticipationCount.fromJson,
        toJson: (update) => update.toJson(),
        box: GetStorageHelper.getStorage()
      );
    return ParticipationCountCache(dataSource: lastUpdateDataSource);
  }
}