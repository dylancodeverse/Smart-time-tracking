import 'package:sola/application/injection_helper/check/service_check.dart';
import 'package:sola/presentation/providers_services/arrival_declaration/declaration.dart';

class ServiceArrivalDeclaration {
  static Future<ArrivalDeclaration>getArrivalDeclaration()async{
    return  ArrivalDeclaration(checkIn: await ServiceCheck.getCheckInService() );
  }
}