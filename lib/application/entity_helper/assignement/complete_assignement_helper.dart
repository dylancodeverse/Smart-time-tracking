import 'package:sola/domain/entity/assignment/complete_assignement.dart';

class CompleteAssignmentHelper {
  static CompleteAssignment fromMap(Map<String, dynamic> map) {
    return CompleteAssignment(
      assignmentDate: map['affectation_date'],
      licensePlate: map['immatriculation'],
      model: map['modele'],
      status: map['statut'],
      driverLastName: map['chauffeur_nom'],
      driverFirstName: map['chauffeur_prenom'],
      coDriverLastName: map['copilote_nom'],
      coDriverFirstName: map['copilote_prenom'],
      isDefault: map['is_default'] , 
    );
  }

  static Map<String, dynamic> toMap(CompleteAssignment data) {
    return {
      'affectation_date': data.assignmentDate,
      'immatriculation': data.licensePlate,
      'modele': data.model,
      'statut': data.status,
      'chauffeur_nom': data.driverLastName,
      'chauffeur_prenom': data.driverFirstName,
      'copilote_nom': data.coDriverLastName,
      'copilote_prenom': data.coDriverFirstName,
      'is_default': data.isDefault,
    };
  }
}
