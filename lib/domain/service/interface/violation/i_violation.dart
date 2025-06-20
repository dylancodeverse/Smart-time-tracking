import 'package:sola/domain/entity/violation/violation.dart';

abstract class IViolation {
  Future<List<Violation>> getAllViolation();
  Future<void> saveAll(List<Violation> violations);
}