import 'package:sola/data/interface/datasource/datasource.dart';
import 'package:sola/domain/entity/complete_participation/complete_participation.dart';
import 'package:sola/domain/service/interface/complete_participation/i_complete_participation.dart';

class CompleteParticipationService implements ICompleteParticipationService {
  final DataSource<CompleteParticipation> completeParticipationDataSource;

  CompleteParticipationService({required this.completeParticipationDataSource});

  @override
  Future<List<CompleteParticipation>> getAll() async{
    return await completeParticipationDataSource.getAll();
  }
}
