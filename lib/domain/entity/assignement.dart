import 'package:sola/domain/entity/bus.dart';
import 'package:sola/domain/entity/copilot.dart';
import 'package:sola/domain/entity/driver.dart';

class Assignment {
  final String id;
  final DateTime assignmentDate;
  final Bus bus;
  final Driver driver;
  final Copilot copilot;
  
  Assignment({
    required this.id,
    required this.assignmentDate,
    required this.driver,
    required this.copilot ,
    required this.bus
  });
}
