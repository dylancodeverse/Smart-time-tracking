import 'package:sola/domain/entity/update_cache/last_update.dart';

abstract class LastUpdateRepository {
  Future<void> save(DateTime date);
  Future<LastUpdate?> getLastUpdate();
  Future<bool> isUpdateNeeded();
}
