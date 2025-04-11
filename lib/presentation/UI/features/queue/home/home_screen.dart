
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sola/presentation/UI/config/theme.dart';
import 'package:sola/presentation/UI/features/queue/home/bus_list_view.dart';
import 'package:sola/presentation/UI/features/queue/home/update_verification/update_button.dart';
import 'package:sola/presentation/UI/widgets/bottomnav.dart';
import 'package:sola/presentation/UI/widgets/search_bar.dart';
import 'package:sola/presentation/providers/home/daily_statistic_list_provider.dart';
import 'package:sola/presentation/UI/features/queue/home/search/search_filters.dart';
import 'package:sola/presentation/providers/home/search_filter_provider.dart';
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<DailyStatisticListProvider>(context, listen: false).getDailyStats());
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

                    // barre de recherche
                    CustomizedSearchBar(controller: Provider.of<FilterProvider>(context,listen: false).searchController, onSearch:  busProvider.filterDailyStats),

                    SizedBox(height: 10),

                    SearchFilters() ,

                    SizedBox(height: 10),
                    // liste
                    UpdateButton(),
              
                    SizedBox(height: 10),

                    BusListView()
                  ],
                );
        },
      ),
      bottomNavigationBar: Bottomnav(),
    );
  }

}
