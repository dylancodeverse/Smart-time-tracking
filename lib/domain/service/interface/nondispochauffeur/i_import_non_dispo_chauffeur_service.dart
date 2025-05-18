import 'package:sola/domain/entity/import/import_non_dispo_chauffeur.dart';

abstract class IImportNonDispoChauffeurService {
  Future<void> saveAll(List<ImportNonDispoChauffeur> lst);
}