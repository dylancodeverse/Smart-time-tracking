import 'package:sola/data/interface/datasource/datasource.dart';
import 'package:sola/domain/entity/statistics/daily_statisitc.dart';
import 'package:sola/domain/service/interface/stats/i_daily_statistic_list_service.dart';
import 'package:string_similarity/string_similarity.dart';

class DailyStatisticListService implements IDailyStatisticListService {
  final DataSource<DailyStatistic> dataSource;

  DailyStatisticListService({required this.dataSource});

  @override
  Future<List<DailyStatistic>> filterByBusName(String busName) async {
    try {
      final allStatistics = await dataSource.getAll();
      final query = busName.toLowerCase().replaceAll(" ", "");

      const double threshold = 0.4;

      return allStatistics.where((statistic) {
        final registration = statistic.busState.lastAssignment?.bus?.registrationNumber?.toLowerCase() ?? "";
        final firstName = statistic.busState.lastAssignment?.driver?.firstName.toLowerCase() ?? "";
        final lastName = statistic.busState.lastAssignment?.driver?.lastName.toLowerCase() ?? "";

        if (query.length < 4) {
          return registration.contains(query) ||
                firstName.contains(query) ||
                lastName.contains(query);
        } else {
          final scores = [
            StringSimilarity.compareTwoStrings(registration, query),
            StringSimilarity.compareTwoStrings(firstName, query),
            StringSimilarity.compareTwoStrings(lastName, query),
          ];

          return scores.any((score) => score >= threshold);
        }
      }).toList();
    } catch (e) {
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
