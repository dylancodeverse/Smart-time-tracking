import 'package:flutter/material.dart';
import 'package:sola/core/theme.dart';
import 'package:sola/data/models/active_bus.dart';
import 'package:sola/presentation/providers/active_bus_list_provider.dart';
import 'package:sola/presentation/providers/active_bus_providers.dart';
import 'package:sola/presentation/widgets/utils/bottomnav.dart';
import 'package:sola/presentation/widgets/bus/bus_card.dart';
import 'package:provider/provider.dart';


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
    print("home screen rebuilt");

    return Scaffold(
      appBar: AppBar(
        title: Text('Cooperative SOLA'),
        scrolledUnderElevation: 0,
      ),
      body: Consumer<ActiveBusListProvider>(
        builder: (context, busProvider, child) {
          return busProvider.isLoading
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Rechercher un véhicule',
                          prefixIcon: Icon(Icons.search, color: AppTheme.primaryColor),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: AppTheme.primaryColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black12, width: 0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black12, width: 0),
                          ),
                        ),
                        onChanged: (query) {
                          busProvider.filterBusList(query);
                        },
                      ),
                    ),
                    Expanded(
                      child: Selector<ActiveBusListProvider, List<ActiveBus>>(
                        selector: (_, provider) => provider.filteredBus,
                        builder: (context, filteredBus, child) {
                          return ListView.builder(
                            itemCount: filteredBus.length,
                            itemBuilder: (context, index) {
                              return ChangeNotifierProvider(
                                  create: (_) => ActiveBusProvider(filteredBus[index]), // ✅ Crée un provider pour chaque bus
                                  child: ActiveBusCard(),
                                );                            },
                          );
                        },
                      ),
                    ),
                  ],
                );
        },
      ),
      bottomNavigationBar: Bottomnav(),
    );
  }

}
