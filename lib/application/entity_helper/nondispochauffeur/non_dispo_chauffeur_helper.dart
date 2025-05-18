import 'package:sola/domain/entity/nondispo/nondispochauffeur.dart';

class NonDispoChauffeurHelper {
  static NonDispoChauffeur fromMap(Map<String,dynamic> map){
    NonDispoChauffeur nonDispoChauffeur = NonDispoChauffeur(
      id: map['id'], 
      idChauffeur:map [ 'id_chauffeur'],
      datedebut:map [ 'datedebut'],
      datefin:map [ 'datefin']);

      return nonDispoChauffeur;
  }

  static Map<String,dynamic> toMap(NonDispoChauffeur nondispo){
    final map = <String, dynamic>{
      'id_chauffeur': nondispo.idChauffeur ,
      'datedebut': nondispo.datedebut ,
      'datefin': nondispo.datefin ,
    };
    return map;
  }
}