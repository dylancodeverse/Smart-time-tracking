import 'package:sola/application/injection_helper/home_statistics/service_daily_statistic_list.dart';
import 'package:sola/data/helper/sqflite/sqflite_database.dart';
import 'package:sola/data/implementation/sqflite/sqflite_datasource.dart';
import 'package:sola/domain/entity/statistics/daily_statisitc.dart';
import 'package:sola/domain/service/implementation/stats/filter_stats_strategy/filter_stats_strategy_impl.dart';
import 'package:sola/domain/service/interface/filter_stats/filter_stats.dart';
import 'package:sola/global/filter_strategy_list.dart';

class FilterStatsStrategyExecutor {

  late final Map<String, FilterStatsStrategy> _strategies;

// Méthode d'initialisation asynchrone
  Future<void> initializeStrategies() async {
    final database = await SqfliteDatabaseHelper().database;
    final sqliteDatasource = SQLiteDataSource(
      database: database,
      tableName: "statistiquejournalier",
      fromMap: InjectiondailystatisticList.fromMap,
      toMap: InjectiondailystatisticList.toMap,
    );

    _strategies = {
      FilterStrategyList.getAllFilterLib(): AllFilter(sqliteDatasource: sqliteDatasource),
      FilterStrategyList.getNotPaidFilterLib(): NotPaidFilter(sqliteDatasource: sqliteDatasource),
      FilterStrategyList.getArrivedFilterLib(): ArrivedFilter(sqliteDatasource: sqliteDatasource),
      FilterStrategyList.getPaidFilterLib(): PaidFilter(sqliteDatasource: sqliteDatasource),
      FilterStrategyList.getOnTheWayFilterLib(): OnTheWayFilter(sqliteDatasource: sqliteDatasource),
    };
  }

  Future<List<DailyStatistic>> executeAction(String action) async {
    final strategy = _strategies[action];
    
    if (strategy != null) {
      return await strategy.execute();  // Appel à execute() si la stratégie existe
    } else {
      throw Exception("Action '$action' non trouvée dans les stratégies");
      // return [];
    }
  }

}