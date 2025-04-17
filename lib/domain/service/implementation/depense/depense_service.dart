import 'package:sola/application/injection_helper/depense/inj_depense.dart';
import 'package:sola/data/interface/datasource/datasource.dart';
import 'package:sola/domain/entity/depense/depense.dart';
import 'package:sola/domain/service/interface/depense/i_depense.dart';
import 'package:sola/lib/date_helper.dart';

class DepenseService implements IDepense{

  DataSource<Depense> depenseDatasource;
  DepenseService({required this.depenseDatasource});

  @override
  Future<Depense> getDepenseToday() async{
    try{
      print("mi test");
      List<Depense> lst= List<Depense>.empty(growable: true);
      lst.add(Depense(amount: 1000, date: Date.getTimestampNow()));
      lst.add(Depense(amount: 2000, date: Date.getTimestampNow()));

      (await InjDepense.getDepenseDatasource()).insertAll(lst);

      return (await depenseDatasource.getAll())[0];
    }catch(e){
      // out of bound
      print("oay legona" +e.toString());
      return Depense(amount: 0, date: Date.getTimestampNow());
    }
  }

  @override
  Future<void> save(Depense depense) async{
    await depenseDatasource.insert(depense);
  }
  
}