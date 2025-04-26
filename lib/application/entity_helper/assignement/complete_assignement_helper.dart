import 'package:sola/domain/entity/assignment/complete_assignement.dart';
import 'package:sola/global/import_export_conf/complete_assignment_configuration.dart';

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

  static CompleteAssignment fromMapIMPORT(Map<String, dynamic> map) {
    return CompleteAssignment(
      assignmentDate: map[CompleteAssignmentConfiguration.affectationDate],
      licensePlate: map[CompleteAssignmentConfiguration.immatriculation],
      model: map[CompleteAssignmentConfiguration.modele],
      status: map[CompleteAssignmentConfiguration.statut],
      driverLastName: map[CompleteAssignmentConfiguration.chauffeurNom],
      driverFirstName: map[CompleteAssignmentConfiguration.chauffeurPrenom],
      coDriverLastName: map[CompleteAssignmentConfiguration.copiloteNom],
      coDriverFirstName: map[CompleteAssignmentConfiguration.copilotePrenom],
      isDefault: map[CompleteAssignmentConfiguration.isDefault] , 
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
