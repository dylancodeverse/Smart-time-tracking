import 'package:sola/domain/entity/participation/stats_participation_with_depense.dart';

class StatsParticipationWithDepenseHelper {
  static StatsParticipationWithDepense fromMap(Map<String, dynamic> map) {
    return StatsParticipationWithDepense(
      participationDate: map['PARTICIPATION_date'],
      montantParticipation: map['montant_participation'],
      depense: map['depense'],
      count: map['count']
    );
  }

  static Map<String, dynamic> toMap(StatsParticipationWithDepense stats) {
    return {
      'PARTICIPATION_date': stats.participationDate,
      'montant_participation': stats.montantParticipation,
      'depense': stats.depense,
      'count': stats.count
    };
  }
}
