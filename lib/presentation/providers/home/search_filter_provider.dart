import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sola/application/strategy/filter_stats_strategy_executor.dart';
import 'package:sola/presentation/providers/home/daily_statistic_list_provider.dart';

class FilterProvider extends ChangeNotifier {


  String _selectedFilter = 'Tous'; // Filtre actif par défaut

  List<String> get filters => FilterStatsStrategyExecutor.filters;
  String get selectedFilter => _selectedFilter;

  void setSelectedFilter(BuildContext context, String filter) {
    _selectedFilter = filter;

    // Accéder au provider DailyStatisticListProvider
    final dailyStatisticProvider = Provider.of<DailyStatisticListProvider>(context, listen: false);
    
    // Exemple : mettre à jour une liste en fonction du filtre sélectionné
    dailyStatisticProvider.filterDailyStatsByPreparedFilter(filter);

    notifyListeners(); // Notifie l'UI de la mise à jour
  }

}
