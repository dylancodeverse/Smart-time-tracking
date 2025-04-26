import 'package:sola/domain/entity/violation/violation.dart';
import 'package:sola/global/violation_configuration.dart';

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

  static Map<String, dynamic> toMapSqlIMPORT(Violation violation) {
    return {
      'lib': violation.lib,
    };
  }

  static Violation fromMapIMPORT(Map<String, dynamic> map) {
    return Violation(
      lib: map[ViolationConfiguration.lib],
    );
  }  
}