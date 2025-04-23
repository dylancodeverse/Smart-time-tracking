import 'package:sola/domain/entity/complete_violation/complete_violation.dart';

abstract class ICompleteViolationService {
  Future<List<CompleteViolation>> getAll();
}
