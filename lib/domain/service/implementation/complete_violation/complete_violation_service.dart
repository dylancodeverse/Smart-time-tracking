import 'package:sola/data/interface/datasource/datasource.dart';
import 'package:sola/domain/entity/complete_violation/complete_violation.dart';
import 'package:sola/domain/service/interface/complete_violation/i_complete_violation.dart';

class CompleteViolationService implements ICompleteViolationService {
  final DataSource<CompleteViolation> completeViolationDataSource;

  CompleteViolationService({required this.completeViolationDataSource});

  @override
  Future<List<CompleteViolation>> getAll() async{
    return await completeViolationDataSource.getAll();
  }
}
