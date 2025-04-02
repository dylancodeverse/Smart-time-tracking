import 'package:sola/domain/entity/update_cache/participation_count.dart';

abstract class IParticipationCountCache {

  Future<void> save();
  Future<void> participationRegistered();
  Future<ParticipationCount?> getParticipationNotPayedCount();
  Future<bool> isUpdateNeeded();
  Future<int> getCount();
  Future<void> reInitCount();

}