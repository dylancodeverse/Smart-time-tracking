import 'package:sola/application/check/service_check.dart';
import 'package:sola/presentation/providers/arrival_declaration/declaration.dart';

class ServiceArrivalDeclaration {
  static Future<ArrivalDeclaration>getArrivalDeclaration()async{
    return  ArrivalDeclaration(checkIn: await ServiceCheck.getCheckInService() );
  }
}