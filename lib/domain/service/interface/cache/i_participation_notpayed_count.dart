import 'package:sola/domain/entity/update_cache/participation_count.dart';

abstract class IParticipationNotpayedCount {

  Future<void> save(int count, DateTime date);
  Future<ParticipationCount?> getParticipationNotPayedCount();
  Future<bool> isUpdateNeeded();
  Future<int> getCount();

}