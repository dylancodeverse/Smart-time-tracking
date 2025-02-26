import 'package:sola/application/check/service_check.dart';
import 'package:sola/application/injection_helper/violation/violation_checking_datasource.dart';
import 'package:sola/domain/service/implementation/violation/violation_checking_service.dart';
import 'package:sola/presentation/providers/arrival_declaration/declaration.dart';

class ServiceArrivalDeclaration {
  static Future<ArrivalDeclaration>getArrivalDeclaration()async{
    return  ArrivalDeclaration(checkIn: await ServiceCheck.getCheckInService(), iViolationChecking: ViolationCheckingService(violationCheckingDatasource: await ViolationCheckingDatasource.getViolationCheckingDatasourceSQFLITE()) );
  }
}