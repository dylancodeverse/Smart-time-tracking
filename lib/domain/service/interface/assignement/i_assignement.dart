import 'package:sola/domain/entity/assignement.dart';

abstract class IAssignement {
  Future<List<Assignment>> getAllByBusId();
}