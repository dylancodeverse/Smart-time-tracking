import 'package:sola/data/interface/datasource/datasource.dart';
import 'package:sola/domain/entity/import/import_non_dispo_chauffeur.dart';
import 'package:sola/domain/service/interface/nondispochauffeur/i_import_non_dispo_chauffeur_service.dart';

class ImportNonDispoChauffeurService implements IImportNonDispoChauffeurService {
  final DataSource<ImportNonDispoChauffeur> nondispoRepo;

  ImportNonDispoChauffeurService({required this.nondispoRepo});


  @override
  Future<void> saveAll(List<ImportNonDispoChauffeur> lst) async{
    await nondispoRepo.insertAll(lst);
  }
  
}