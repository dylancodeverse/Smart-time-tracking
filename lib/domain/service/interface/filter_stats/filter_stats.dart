import 'package:sola/domain/entity/statistics/daily_statisitc.dart';

abstract class FilterStatsStrategy {
  Future<List<DailyStatistic>> execute();

}
