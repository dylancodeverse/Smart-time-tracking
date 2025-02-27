
import 'package:sola/data/interface/datasource/datasource.dart';
import 'package:sola/domain/entity/participation/participation.dart';
import 'package:sola/domain/service/interface/participation/i_participation.dart';
import 'package:sola/lib/date_helper.dart';

class ParticipationRepository implements IParticipation {

  DataSource<Participation> participationDatasource; 

  ParticipationRepository({required this.participationDatasource});

  @override
  Future<void> saveParticipation(String busId, int amount , String ? comments) async {
    await participationDatasource.insert(Participation(busId: busId, participationDate: Date.getTimestampNow(), amount: amount, comments: comments));
  }
}
