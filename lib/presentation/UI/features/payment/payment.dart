

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sola/global/filter_strategy_list.dart';
import 'package:sola/presentation/UI/config/theme.dart';
import 'package:sola/presentation/UI/features/payment/payment_card.dart';
import 'package:sola/presentation/UI/features/queue/home/bus_list_view.dart';
import 'package:sola/presentation/UI/widgets/bottomnav.dart';
import 'package:sola/presentation/UI/widgets/search_bar.dart';
import 'package:sola/presentation/providers/home/daily_statistic_list_provider.dart';
import 'package:sola/presentation/providers/home/search_filter_provider.dart';

class Payment extends StatefulWidget {
  @override
  _PaymentState createState() => _PaymentState();
}
class _PaymentState extends State<Payment> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<DailyStatisticListProvider>(context, listen: false).filterDailyStatsByPreparedFilter(FilterStrategyList.filters[1]));
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(AppTheme.appName),
        scrolledUnderElevation: 0,
      ),
      body: Consumer<DailyStatisticListProvider>(
        builder: (context, busProvider, child) {
          return busProvider.isLoading
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: [
      
                    SizedBox(height: 10),

                    CustomizedSearchBar(controller: Provider.of<FilterProvider>(context,listen: false).searchController, onSearch:  busProvider.filterDailyStats),
                    
                    SizedBox(height: 10),
                    // barre de recherche
                    PaymentCard(),
                          
                    SizedBox(height: 14),
              
                    Text("Participations non payées"),

                    SizedBox(height: 10),

                    BusListView()
                  ],
                );
        },
      ),
      bottomNavigationBar: Bottomnav(currentIndex: 1,),
    );
  }

}
