import 'package:sola/data/interface/datasource/datasource.dart';
import 'package:sola/domain/entity/violation/violation.dart';
import 'package:sola/domain/service/interface/violation/i_violation.dart';

class ViolationService implements IViolation{

  DataSource<Violation> violationDatasource;

  ViolationService({required this.violationDatasource});

  @override
  Future< List<Violation>> getAllViolation() async{
    return await violationDatasource.getAll();
  }
}