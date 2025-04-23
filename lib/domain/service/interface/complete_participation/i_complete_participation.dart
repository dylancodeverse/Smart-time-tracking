import 'package:sola/domain/entity/complete_participation/complete_participation.dart';

abstract class ICompleteParticipationService {
  Future<List<CompleteParticipation>> getAll();
}
