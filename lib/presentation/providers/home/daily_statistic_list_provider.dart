import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sola/application/injection_helper/bus_state/bus_state_custom_inj.dart';
import 'package:sola/application/strategy/filter_stats_strategy_executor.dart';
import 'package:sola/domain/service/interface/stats/i_daily_statistic_list_service.dart';
import 'package:sola/presentation/model/stats/daily_statistic.dart';
import 'package:sola/presentation/providers/home/search_filter_provider.dart';

class DailyStatisticListProvider with ChangeNotifier{
  final IDailyStatisticListService iDailyStatisticListService;
  DailyStatisticListProvider({required this.iDailyStatisticListService});


  bool isLoading = false;
  List<DailyStatisticView> busList = [];
  List<DailyStatisticView> filteredBus = [];
  
  void loading(){
    isLoading=true;
    notifyListeners();
  }
  void finish(){
    isLoading=false;
    notifyListeners();
  }

  void getDailyStats() async{
      loading();
      busList = DailyStatisticView.convert(await iDailyStatisticListService.getDailyStatistics())  ;
      filteredBus = busList;
      finish();
  }

  void filterDailyStats(BuildContext context, String query) async{
    // loading();
    if (query.isEmpty){
      filteredBus= busList;
    }  else{
    filteredBus = DailyStatisticView.convert(await iDailyStatisticListService.filterByBusName(query));
    }
    Provider.of<FilterProvider>( context,listen: false).reinitSelectedFilter();

    finish();
  }

  void filterDailyStatsByPreparedFilter(String requirement) async{
    if (requirement.isEmpty) {
      return;
    }
    FilterStatsStrategyExecutor filterStatsStrategyExecutor = FilterStatsStrategyExecutor() ;
    await filterStatsStrategyExecutor.initializeStrategies();
    filteredBus = DailyStatisticView.convert(await filterStatsStrategyExecutor.executeAction(requirement));
    finish();
  }

  void updateVerification()async{
    await (await BusStateCustomINJ.getBusStateCustomImpl()).verification();
    getDailyStats();
  }

}