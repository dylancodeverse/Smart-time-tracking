import 'package:sola/data/interface/datasource/datasource.dart';
import 'package:sola/domain/entity/violation/violation_checking.dart';
import 'package:sola/domain/service/interface/violation/i_violation_checking.dart';

class ViolationCheckingService implements IViolationChecking {
  
  DataSource<ViolationChecking> violationCheckingDatasource ;

  ViolationCheckingService({required this.violationCheckingDatasource});


  @override
  Future<void> saveViolationChecking(ViolationChecking violationChecking) async{
    await violationCheckingDatasource.insert(violationChecking);
  }
  
}