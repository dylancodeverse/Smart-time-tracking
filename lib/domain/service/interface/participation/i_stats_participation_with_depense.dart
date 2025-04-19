import 'package:sola/domain/entity/participation/stats_participation_with_depense.dart';

abstract class IStatsParticipationWithDepense {

  /// Get today's stats (single row)
  Future<StatsParticipationWithDepense> getTodayStats();

  /// Get all daily stats from the view
  // Future<List<StatsParticipationWithDepense>> getAllStats();
}
