import 'package:sola/domain/entity/assignment/complete_assignement.dart';

abstract class ICompleteAssignement {
  Future<List<CompleteAssignment>> getAllCompleteAssignments();
  Future<void> saveAll(List<CompleteAssignment> completeAssignments);
}