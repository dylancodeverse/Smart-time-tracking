import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sola/presentation/UI/features/home/bus_card/bus_card.dart';
import 'package:sola/presentation/providers/home/daily_statistic_list_provider.dart';
import 'package:sola/presentation/providers/home/daily_statistic_provider.dart';
import 'package:sola/presentation/model/stats/daily_statistic.dart';

class BusListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<DailyStatisticListProvider>(
        builder: (context, busProvider, child) {
          List<DailyStatisticView> filteredBus = busProvider.filteredBus;
    
          return ListView.builder(
            itemCount: filteredBus.length,
            itemBuilder: (context, index) {
              return ChangeNotifierProvider(
                key: ValueKey(filteredBus[index].busID), // 🔹 Clé pour forcer la reconstruction
                create: (_) => DailyStatisticProvider( index: index,bus: filteredBus[index],dailyStatisticListProvider: busProvider), 
                  child: BusCard(key: ValueKey(filteredBus[index].registrationNumber)), 

              );
            },
          );
        },
      ),
    );
  }
}
