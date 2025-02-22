import 'package:sola/domain/entity/bus.dart';
import 'package:sola/domain/entity/copilot.dart';
import 'package:sola/domain/entity/driver.dart';

class Assignment {
  String? id;
  DateTime? assignmentDate;
  Bus? bus;
  Driver? driver;
  Copilot? copilot;
  
  Assignment({
    this.id,
    this.assignmentDate,
    this.driver,
    this.copilot ,
    this.bus
  });
}
