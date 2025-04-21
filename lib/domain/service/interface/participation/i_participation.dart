
import 'package:sola/domain/entity/participation/participation.dart';

abstract class IParticipation {
  Future<void> saveParticipation(String busId, int amount, String comments, int busStateId);

  Future<void> update(Participation participation);
}
