import 'package:sola/domain/entity/assignement.dart';
import 'package:sola/domain/entity/bus.dart';
import 'package:sola/domain/entity/copilot.dart';
import 'package:sola/domain/entity/driver.dart';

class AssignementHelper {
  static Map<String, dynamic> toMap(Assignment assignment) {
    return {
      "id": assignment.id,
      "affectation_date": assignment.assignmentDate,
      "vehicule_id": assignment.bus!.id!,
      "chauffeur_id": assignment.driver!.id,
      "copilote_id": assignment.copilot!.id,
    };
  }


  // Create an instance from a Map
  static Assignment fromMap(Map<String, dynamic> map) {
    return Assignment(
      id: map["affectation_id"].toString(),
      assignmentDate: DateTime.parse(map["affectation_date"]),
      bus: Bus(
        id: map["vehicule_id"].toString(),
        registrationNumber: map["immatriculation"],
        model: map["modele"],
        status: map["statut"] ?? 0,
      ),
      driver: Driver(
        id: map["chauffeur_id"].toString(),
        lastName: map["chauffeur_nom"],
        firstName: map["chauffeur_prenom"],
      ),
      copilot: Copilot(
        id: map["copilote_id"].toString(),
        lastName: map["copilote_nom"],
        firstName: map["copilote_prenom"],
      ),
    );
  }  
}


