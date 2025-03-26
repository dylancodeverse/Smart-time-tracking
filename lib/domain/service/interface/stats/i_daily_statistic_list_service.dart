import 'package:sola/domain/entity/statistics/daily_statisitc.dart';

abstract class IDailyStatisticListService {
  Future<List<DailyStatistic>> getDailyStatistics();

  Future<List<DailyStatistic>> filterByBusName(String busName);

}
