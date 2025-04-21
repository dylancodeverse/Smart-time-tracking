import 'package:sola/data/interface/datasource/datasource.dart';
import 'package:sola/domain/entity/depense/depense.dart';
import 'package:sola/domain/excpetion/commentaire_exception.dart';
import 'package:sola/domain/service/interface/depense/i_depense.dart';
import 'package:sola/lib/date_helper.dart';

class DepenseService implements IDepense{

  DataSource<Depense> depenseDatasource;
  DepenseService({required this.depenseDatasource});


  @override
  Future<void> save(Depense depense) async{
    depense.date= Date.getTimestampNow();
    depense.reason??="";
    if (depense.reason=="") {
      throw CommentsException();
    }
    await depenseDatasource.insert(depense);
  }
  
  @override
  Future<List<Depense>> getAll()async {
    return await depenseDatasource.getAll();
  }
  
  @override
  Future<void> update(Depense depense) async{
    depense.reason??= "";
    if (depense.reason=="") {
      throw CommentsException();
    }
    await depenseDatasource.updateAndIgnoreNullColumns(depense);
  }
  
}