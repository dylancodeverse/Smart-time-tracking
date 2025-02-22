import 'package:sola/data/interface/datasource/datasource.dart';
import 'package:sola/domain/entity/statistics/daily_statisitc.dart';
import 'package:sola/domain/service/interface/i_daily_statistic_list_service.dart';

class DailyStatisticListService implements IDailyStatisticListService {
  final DataSource<DailyStatistic> dataSource;

  DailyStatisticListService({required this.dataSource});

  @override
  Future<List<DailyStatistic>> filterByBusName(String busName) async {
    try {
      // Si possible, ajouter un filtrage au niveau de la base de données.
      final allStatistics = await dataSource.getAll();

      return allStatistics
        .where((statistic) => statistic.assignment.bus.registrationNumber.toLowerCase() == busName.toLowerCase())
        .toList();
    } catch (e) {
      // Gestion d'erreur
      throw Exception("Error filtering by bus name: $e");
    }
  }

  @override
  Future<List<DailyStatistic>> getDailyStatistics() async {
    try {
      return await dataSource.getAll();
    } catch (e) {
      // Gestion d'erreur
      throw Exception("Error fetching daily statistics: $e");
    }
  }
}
