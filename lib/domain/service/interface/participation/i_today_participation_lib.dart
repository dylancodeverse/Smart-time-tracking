import 'package:sola/domain/entity/participation/today_participation.dart';

abstract class ITodayParticipationLib {
  Future<List<TodayParticipationLib>> getTodayParticipationsLib();
}
