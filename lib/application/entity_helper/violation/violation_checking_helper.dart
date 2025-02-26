
import 'package:sola/domain/entity/violation/violation_checking.dart';

class ViolationCheckingHelper {
    // Conversion d'une instance en une map pour l'insertion dans la base de données
  static Map<String, dynamic> toMap(ViolationChecking violation) {
    return {
      'id': violation.id,
      'id_violation': violation.violationId,
      'id_pointage': violation.checkId,
    };
  }

  // Conversion d'une map en une instance de Violation
  static ViolationChecking fromMap(Map<String, dynamic> map) {
    return ViolationChecking(
      id: map['id'],
      violationId: map['id_violation'],
      checkId: map['id_pointage'],
    );
  }  
}