
import 'package:sola/data/interface/datasource/datasource.dart';
import 'package:sola/domain/entity/bus_state.dart';
import 'package:sola/domain/entity/participation/participation.dart';
import 'package:sola/domain/service/interface/cache/i_participation_notpayed_count.dart';
import 'package:sola/domain/service/interface/participation/i_participation.dart';
import 'package:sola/global/participation.dart';
import 'package:sola/lib/date_helper.dart';

class ParticipationRepository implements IParticipation {

  DataSource<Participation> participationDatasource; 
  DataSource<BusState> busStateDatasource;
  IParticipationCountCache participationCountServiceCache; 

  ParticipationRepository({required this.participationDatasource, required this.busStateDatasource , required this.participationCountServiceCache});

  @override
  Future<void> saveParticipation(String busId, int amount , String ? comments , int busStateId ) async {
    await participationDatasource.insert(Participation(busId: busId, participationDate: Date.getTimestampNow(), amount: amount, comments: comments));
    await busStateDatasource.updateAndIgnoreNullColumns(BusState(id: busStateId , participationState: ParticipationVar.okParticipation));
    await participationCountServiceCache.participationRegistered(); 
  }
}
