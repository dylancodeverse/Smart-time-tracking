import 'package:sola/domain/entity/violation/violation_checking.dart';

abstract class IViolationChecking {
  Future<void> saveViolationChecking( List<ViolationChecking> violationChecking);
}