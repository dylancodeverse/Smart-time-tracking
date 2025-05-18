import 'package:sola/application/entity_helper/nondispochauffeur/non_dispo_chauffeur_helper.dart';
import 'package:sola/data/helper/sqflite/sqflite_database.dart';
import 'package:sola/data/implementation/sqflite/sqflite_datasource.dart';
import 'package:sola/data/interface/datasource/datasource.dart';
import 'package:sola/domain/entity/nondispo/nondispochauffeur.dart';
import 'package:sola/domain/service/implementation/nondispochauffeur/non_dispo_chauffeur_service.dart';
import 'package:sola/domain/service/interface/nondispochauffeur/i_non_dispo_chauffeur.dart';

class InjNonDispoChauffeur {
  static Future<DataSource<NonDispoChauffeur>> getNonDispoChauffeurRepo() async{
    return SQLiteDataSource(database: await SqfliteDatabaseHelper().database, tableName: 
    "NONDISPOCHAUFFEUR", fromMap: NonDispoChauffeurHelper.fromMap, toMap: NonDispoChauffeurHelper.toMap);
  }
  static Future<INonDispoChauffeur> getNonDispoChauffeurServiceInstance() async{
    return  NonDispoChauffeurService(nondispoRepo: await getNonDispoChauffeurRepo());
  }
}