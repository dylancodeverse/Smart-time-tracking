import 'package:sola/data/interface/datasource/datasource.dart';
import 'package:sola/domain/entity/assignement.dart';
import 'package:sola/domain/service/interface/assignement/i_assignement.dart';

class AssignementService implements IAssignement {

  DataSource<Assignment> assignementDatasource;


  AssignementService({required this.assignementDatasource});

  @override
  Future<List<Assignment>> getAllByBusId() async{
    return await assignementDatasource.getAll();
  }
  
}