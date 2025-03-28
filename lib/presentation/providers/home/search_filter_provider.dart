import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sola/global/filter_strategy_list.dart';
import 'package:sola/presentation/model/filter/filter_home.dart';
import 'package:sola/presentation/providers/home/daily_statistic_list_provider.dart';

class FilterProvider extends ChangeNotifier {


  String _selectedFilter =  FilterStrategyList.getDefault(); // Filtre actif par défaut
  final TextEditingController searchController = TextEditingController();

  String get selectedFilter => _selectedFilter;

  void setSelectedFilter(BuildContext context, String filter) {
    _selectedFilter = filter;

    // Accéder au provider DailyStatisticListProvider
    final dailyStatisticProvider = Provider.of<DailyStatisticListProvider>(context, listen: false);
    
    // Exemple : mettre à jour une liste en fonction du filtre sélectionné
    dailyStatisticProvider.filterDailyStatsByPreparedFilter(filter);
    searchController.clear();
    notifyListeners(); // Notifie l'UI de la mise à jour
  }
  void reinitSelectedFilter(){
    if (_selectedFilter== FilterStrategyList.getDefault()) {
      return;
    }
    _selectedFilter= FilterStrategyList.getDefault();
    notifyListeners();
  }

  List<FilterHome> getFilterList() {
    List<FilterHome> list = [];
    list.add(FilterHome(lib: FilterStrategyList.getAllFilterLib()));
    list.add(FilterHome(lib: FilterStrategyList.getNotPaidFilterLib() , notificationCount: 3));
    list.add(FilterHome(lib: FilterStrategyList.getArrivedFilterLib()));
    list.add(FilterHome(lib: FilterStrategyList.getOnTheWayFilterLib()));
    list.add(FilterHome(lib: FilterStrategyList.getPaidFilterLib()));
    return list;
  }
  

}
