import 'package:sola/application/data_init/raw_query.dart';
import 'package:sola/data/interface/datasource/datasource.dart';
import 'package:sola/domain/entity/nondispo/nondispochauffeur.dart';
import 'package:sola/domain/service/interface/nondispochauffeur/i_non_dispo_chauffeur.dart';

class NonDispoChauffeurService implements INonDispoChauffeur {

  DataSource<NonDispoChauffeur>  nondispoRepo ;

  NonDispoChauffeurService({required this.nondispoRepo});

  @override
  Future<List<NonDispoChauffeur>> nonDispoListe(String chauffeurId) async{
    return  await nondispoRepo.getWithRawQuery(RawQuery.nondispo.replaceAll("'%'", "'$chauffeurId'"));
  }
  
}