import 'package:sola/application/entity_helper/import/import_non_dispo_chauffeur_helper.dart';
import 'package:sola/data/helper/sqflite/sqflite_database.dart';
import 'package:sola/data/implementation/sqflite/sqflite_datasource.dart';
import 'package:sola/data/interface/datasource/datasource.dart';
import 'package:sola/domain/entity/import/import_non_dispo_chauffeur.dart';
import 'package:sola/domain/service/implementation/nondispochauffeur/import_non_dispo_chauffeur_service.dart';
import 'package:sola/domain/service/interface/nondispochauffeur/i_import_non_dispo_chauffeur_service.dart';

class InjImportNonDispoChauffeur {
  static Future<DataSource<ImportNonDispoChauffeur>> getImportNonDispoChauffeurRepo() async{
    return SQLiteDataSource(database: await SqfliteDatabaseHelper().database, tableName: 
    "IMPORTNONDISPOCHAUFFEUR", fromMap: ImportNonDispoChauffeurHelper.fromMap, toMap: ImportNonDispoChauffeurHelper.toMap);
  }
  static Future<IImportNonDispoChauffeurService> getIImportNonDispoChauffeurService() async{
    return  ImportNonDispoChauffeurService(nondispoRepo: await getImportNonDispoChauffeurRepo());
  }
}