import 'package:sola/data/interface/datasource/datasource.dart';
import 'package:sola/domain/entity/participation/stats_participation_with_depense.dart';
import 'package:sola/domain/service/interface/participation/i_stats_participation_with_depense.dart';

class StatsParticipationWithDepenseService implements IStatsParticipationWithDepense{

  DataSource<StatsParticipationWithDepense> statsParticipationWithDepenseDatasource ;

  StatsParticipationWithDepenseService({required this.statsParticipationWithDepenseDatasource});

  @override
  Future<StatsParticipationWithDepense> getTodayStats() async{
    return (await statsParticipationWithDepenseDatasource.getAll())[0];
  }
  
}