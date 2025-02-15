import 'package:flutter/material.dart';
import 'package:sola/core/theme.dart';
import 'package:sola/presentation/features/home/bus_list_view.dart';
import 'package:sola/presentation/providers/active_bus_list_provider.dart';
import 'package:sola/presentation/widgets/utils/bottomnav.dart';
import 'package:provider/provider.dart';
import 'package:sola/presentation/widgets/utils/search_bar.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<ActiveBusListProvider>(context, listen: false).fetchActiveBusses());
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(AppTheme.appName),
        scrolledUnderElevation: 0,
      ),
      body: Consumer<ActiveBusListProvider>(
        builder: (context, busProvider, child) {
          return busProvider.isLoading
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    // barre de recherche
                    CustomizedSearchBar(controller: _searchController, onSearch:  busProvider.filterBusList),
                    // liste
                    BusListView(),
                  ],
                );
        },
      ),
      bottomNavigationBar: Bottomnav(),
    );
  }

}
