import 'package:sola/data/helper/sqflite/sqflite_database.dart';
import 'package:sola/data/mock/init_datas.dart';
import 'package:sqflite/sqflite.dart';

class ServiceInitdb {
  static initSQFlite(bool reset)async{
    final dbPath = await SqfliteDatabaseHelper.getDbPath();
    if(reset){
      await deleteDatabase(dbPath); // Supprime l'ancienne base
    }
    // create tables if not created
    Database db= await  SqfliteDatabaseHelper().database;
    if (reset) {
      await InitDatas().insertInitialData(db);      
    }
  }
  
}