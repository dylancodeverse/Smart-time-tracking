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
      horsepower:map['puissance_chevaux'] ??0,
      fuelConsumptionL100Km:map['consommation_l_100km'] ??0,
      weightKg:map['poids_kg'] ??0,
      widthMm:map['largeur_mm'] ??0,
      heightMm:map['hauteur_mm'] ??0,
      launchYear:map['annee_lancement'] ??0,
      lengthMm:map['longueur_mm'] ??0,
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
      horsepower: map[CompleteAssignmentConfiguration.horsepower] ?? 0,
      fuelConsumptionL100Km: map[CompleteAssignmentConfiguration.fuelConsumptionL100Km] ?? 0.0,
      weightKg: map[CompleteAssignmentConfiguration.weightKg] ?? 0,
      widthMm: map[CompleteAssignmentConfiguration.widthMm] ?? 0,
      heightMm: map[CompleteAssignmentConfiguration.heightMm] ?? 0,
      launchYear: map[CompleteAssignmentConfiguration.launchYear] ?? 0,
      lengthMm: map[CompleteAssignmentConfiguration.lengthMm] ?? 0,


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
      'puissance_chevaux': data.horsepower,
      'consommation_l_100km': data.fuelConsumptionL100Km,
      'poids_kg': data.weightKg,
      'largeur_mm': data.widthMm,
      'hauteur_mm': data.heightMm,
      'annee_lancement': data.launchYear,
      'longueur_mm': data.lengthMm,
    };
  }
}
