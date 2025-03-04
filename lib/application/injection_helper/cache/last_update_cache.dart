import 'package:sola/data/implementation/sqflite/shared_preferences_datasource.dart';
import 'package:sola/domain/entity/update_cache/last_update.dart';
import 'package:sola/domain/service/implementation/cache/last_update_repo.dart';

class LastUpdateCache {
  static LastUpdateRepositoryImpl getLastUpdateRepositoryImpl(){
    SharedPreferencesDataSource<LastUpdate>lastUpdateDataSource = SharedPreferencesDataSource<LastUpdate>(
        key: "last_update",
        fromJson: LastUpdate.fromJson,
        toJson: (update) => update.toJson(),
      );
    return LastUpdateRepositoryImpl(lastUpdateDataSource);
  }
}