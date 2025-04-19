import 'package:sola/application/entity_helper/depense/depense_helper.dart';
import 'package:sola/data/helper/sqflite/sqflite_database.dart';
import 'package:sola/data/implementation/sqflite/sqflite_datasource.dart';
import 'package:sola/data/interface/datasource/datasource.dart';
import 'package:sola/domain/entity/depense/depense.dart';
import 'package:sola/domain/service/implementation/depense/depense_service.dart';

class InjDepense {
  static Future<DataSource<Depense>> getDepenseDatasource() async{
    return SQLiteDataSource(database: await SqfliteDatabaseHelper().database,
     tableName: "MOTIFDEPENSE", fromMap: DepenseHelper.fromMap, toMap: DepenseHelper.toMap);
  }

  static Future<DepenseService> getDepenseService() async{
    return DepenseService(depenseDatasource: await getDepenseDatasource());
  }
  
}