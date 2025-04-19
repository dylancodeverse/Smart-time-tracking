import 'package:sola/data/helper/sharedpreferences/database_reinit.dart';
import 'package:sola/data/implementation/cache/get_storage_datasource.dart';
import 'package:sola/domain/entity/update_cache/last_update.dart';
import 'package:sola/domain/service/implementation/cache/last_update_repo.dart';

class LastUpdateCache {
  static Future<LastUpdateRepositoryImpl> getLastUpdateRepositoryImpl() async{
    GetStorageDataSource<LastUpdate>lastUpdateDataSource = GetStorageDataSource<LastUpdate>(
        key:"last_update" ,
        fromJson: LastUpdate.fromJson,
        toJson: (update) => update.toJson(),
        box: await GetStorageHelper.getStorage()
      );
    return LastUpdateRepositoryImpl(lastUpdateDataSource);
  }
}