import 'package:sola/domain/entity/import/import_non_dispo_chauffeur.dart';
import 'package:sola/global/import_export_conf/import_non_dispo_chauffeur_configuration.dart';

class ImportNonDispoChauffeurHelper {
    static ImportNonDispoChauffeur fromMap(Map<String, dynamic> map) {
    return ImportNonDispoChauffeur(
      datedebut: map['datedebut'],
      datefin:   map['datefin'],
      nom:      map['nom'],
      prenom:   map['prenom'],

    );
  }

  static Map<String, dynamic> toMap(ImportNonDispoChauffeur entity) {
    return {
      'datedebut': entity.datedebut,
      'datefin': entity.datefin,
      'nom': entity.nom,
      'prenom': entity.prenom,      
    };
  }
  static ImportNonDispoChauffeur fromMapIMPORT(Map<String, dynamic> map) {
    return ImportNonDispoChauffeur(
      datedebut: map[ ImportNonDispoChauffeurConfiguration.datedebut],
      datefin: map[ ImportNonDispoChauffeurConfiguration.datefin],
      nom: map[ ImportNonDispoChauffeurConfiguration.nom],
      prenom: map[ ImportNonDispoChauffeurConfiguration.prenom],
    );
  }  
}
