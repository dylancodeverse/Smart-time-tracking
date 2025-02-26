import 'package:flutter/foundation.dart';
import 'package:sola/domain/service/interface/stats/i_daily_statistic_list_service.dart';
import 'package:sola/presentation/model/daily_statistic.dart';

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

  void filterDailyStats(String query) async{
    loading();
    if (query.isEmpty){
      filteredBus= busList;
    }  else{
    filteredBus = DailyStatisticView.convert(await iDailyStatisticListService.filterByBusName(query));
    }
    finish();
  }

}