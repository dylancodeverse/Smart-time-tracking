import 'package:sola/data/interface/datasource/datasource.dart';
import 'package:sola/domain/entity/update_cache/last_update.dart';
import 'package:sola/domain/service/interface/cache/i_last_update_repo.dart';

class LastUpdateRepositoryImpl implements LastUpdateRepository {
  final DataSource<LastUpdate> dataSource;

  LastUpdateRepositoryImpl(this.dataSource);

  @override
  Future<void> save(DateTime date) async {
    await dataSource.insert(LastUpdate(date: date));
  }

  @override
  Future<LastUpdate?> getLastUpdate() async {
    List<LastUpdate> updates = await dataSource.getAll();
    return updates.isNotEmpty ? updates[0] : null;
  }

  @override
  Future<bool> isUpdateNeeded() async {
    final lastUpdate = await getLastUpdate();
    final today = DateTime.now().toIso8601String().split('T')[0];
    return lastUpdate?.date.toIso8601String().split('T')[0] != today;
  }
}
