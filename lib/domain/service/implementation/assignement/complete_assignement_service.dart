import 'package:sola/data/interface/datasource/datasource.dart';
import 'package:sola/domain/entity/assignment/complete_assignement.dart';
import 'package:sola/domain/service/interface/assignement/i_complete_assignement.dart';

class CompleteAssignementService implements ICompleteAssignement {
  final DataSource<CompleteAssignment> assignementRepository;

  CompleteAssignementService({
    required this.assignementRepository,
  });
  
  @override
  Future<List<CompleteAssignment>> getAllCompleteAssignments() {
    return assignementRepository.getAll();
  }
  
  @override
  Future<void> saveAll(List<CompleteAssignment> completeAssignments) async{
    return await assignementRepository.insertAll(completeAssignments);
  }


  
}