import 'package:sola/data/interface/datasource/datasource.dart';
import 'package:sola/domain/entity/depense/depense.dart';
import 'package:sola/domain/service/interface/depense/i_depense.dart';

class DepenseService implements IDepense{

  DataSource<Depense> depenseDatasource;
  DepenseService({required this.depenseDatasource});


  @override
  Future<void> save(Depense depense) async{
    await depenseDatasource.insert(depense);
  }
  
}