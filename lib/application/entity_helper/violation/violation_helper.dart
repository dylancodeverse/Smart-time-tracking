import 'package:sola/domain/entity/violation/violation.dart';

class ViolationHelper {
    // Conversion d'une instance en une map pour l'insertion dans la base de données
  static Map<String, dynamic> toMap(Violation violation) {
    return {
      'id': violation.id,
      'lib': violation.lib,
    };
  }

  // Conversion d'une map en une instance de Violation
  static Violation fromMap(Map<String, dynamic> map) {
    return Violation(
      id: map['id'],
      lib: map['lib'],
    );
  }  

  static Map<String, dynamic> toMapIMPORT(Violation violation) {
    return {
      'lib': violation.lib,
    };
  }

  // Conversion d'une mapIMPORT en une instance de Violation
  static Violation fromMapIMPORT(Map<String, dynamic> map) {
    return Violation(
      lib: map['lib'],
    );
  }  
}