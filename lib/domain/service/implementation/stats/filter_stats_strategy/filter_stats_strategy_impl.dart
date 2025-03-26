
import 'package:sola/data/implementation/sqflite/sqflite_datasource.dart';
import 'package:sola/domain/entity/statistics/daily_statisitc.dart';
import 'package:sola/domain/service/interface/filter_stats/filter_stats.dart';

class AllFilter implements FilterStatsStrategy {
  SQLiteDataSource<DailyStatistic> sqliteDatasource ;
  AllFilter({required this.sqliteDatasource});

  @override
  Future<List<DailyStatistic>> execute() async {
    return await sqliteDatasource.getAll();    
  }
}

class NotPaidFilter implements FilterStatsStrategy {
  SQLiteDataSource<DailyStatistic> sqliteDatasource ;
  NotPaidFilter({required this.sqliteDatasource});

  @override
  Future<List<DailyStatistic>> execute() async {
    sqliteDatasource.tableName= "statistiquejournalierParticipationNonPayee";
    return await sqliteDatasource.getAll();
  } 

}

class PaidFilter implements FilterStatsStrategy {
  SQLiteDataSource<DailyStatistic> sqliteDatasource ;
  PaidFilter({required this.sqliteDatasource});
  
  @override
  Future<List<DailyStatistic>> execute() async 
  {
    sqliteDatasource.tableName= "statistiquejournalierParticipationOK";
    return await sqliteDatasource.getAll();
  }
}

class ArrivedFilter implements FilterStatsStrategy {
  
  SQLiteDataSource<DailyStatistic> sqliteDatasource ;
  ArrivedFilter({required this.sqliteDatasource});

  @override
  Future<List<DailyStatistic>> execute() async 
  {
    sqliteDatasource.tableName= "statistiquejournalierVoitureSurTerminus";
    return await sqliteDatasource.getAll();
  }
  
}

class OnTheWayFilter implements FilterStatsStrategy {

  SQLiteDataSource<DailyStatistic> sqliteDatasource ;
  OnTheWayFilter({required this.sqliteDatasource});

  @override
  Future<List<DailyStatistic>> execute() async 
  {
    sqliteDatasource.tableName= "statistiquejournalierVoitureSurRoute";
    return await sqliteDatasource.getAll();
  }
}