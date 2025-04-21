import 'package:sola/data/interface/datasource/datasource.dart';
import 'package:sola/domain/entity/participation/today_participation.dart';
import 'package:sola/domain/service/interface/participation/i_today_participation_lib.dart';

class TodayParticipationLibService implements ITodayParticipationLib{
  
  DataSource<TodayParticipationLib> todayParticipationLibDatasource;

  TodayParticipationLibService({required this.todayParticipationLibDatasource});

  @override
  Future<List<TodayParticipationLib>> getTodayParticipationsLib() async{
    return await todayParticipationLibDatasource.getAll();
  }
  
}