import 'package:sola/domain/entity/complete_violation/complete_violation.dart';

class CompleteViolationHelper {
  static CompleteViolation fromMap(Map<String, dynamic> map) {
    return CompleteViolation(
      arrivalDate: map['date_arrivee'],
      departureDate: map['date_depart'],
      registration: map['immatriculation'],
      driverLastName: map['chauffeur_nom'],
      driverFirstName: map['chauffeur_prenom'],
      coDriverLastName: map['copilote_nom'],
      coDriverFirstName: map['copilote_prenom'],
      amount: map['montant']?.toDouble(),
      comments: map['commentaires'],
      violationLabel: map['violation_libelle'],
    );
  }

  static Map<String, dynamic> toMap(CompleteViolation entity) {
    return {
      'date_arrivee': entity.arrivalDate,
      'date_depart': entity.departureDate,
      'immatriculation': entity.registration,
      'chauffeur_nom': entity.driverLastName,
      'chauffeur_prenom': entity.driverFirstName,
      'copilote_nom': entity.coDriverLastName,
      'copilote_prenom': entity.coDriverFirstName,
      'montant': entity.amount,
      'commentaires': entity.comments,
      'violation_libelle': entity.violationLabel,
    };
  }
}
