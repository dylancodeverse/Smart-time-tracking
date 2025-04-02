import 'package:sola/domain/entity/update_cache/participation_count.dart';

abstract class IParticipationNotpayedCount {

  Future<void> save();
  Future<ParticipationCount?> getParticipationNotPayedCount();
  Future<bool> isUpdateNeeded();
  Future<int> getCount();

}