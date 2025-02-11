import 'package:flutter/material.dart';
import 'package:sola/core/theme.dart';
import 'package:sola/presentation/providers/active_bus_providers.dart';
import 'package:sola/presentation/widgets/utils/bottomnav.dart';
import 'package:sola/presentation/widgets/bus/bus_card.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<ActiveBusProvider>(context, listen: false).fetchActiveBuss());
  }
  @override
  Widget build(BuildContext context) {
    final busProvider = Provider.of<ActiveBusProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Cooperative SOLA'),
        scrolledUnderElevation: 0,
      ),
      body: busProvider.isLoading
          ? Center(child: CircularProgressIndicator())
      :Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Rechercher un véhicule',
                prefixIcon: Icon(Icons.search, color: AppTheme.primaryColor),
                filled: true, // ✅ Active le remplissage
                fillColor: Colors.white, // ✅ Définit la couleur de fond en blanc
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: AppTheme.primaryColor),
                ),
                enabledBorder: OutlineInputBorder( // ✅ Ajoute une bordure propre quand non focus
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black12,width: 0),
                ),
                focusedBorder: OutlineInputBorder( // ✅ Ajoute une bordure quand focus
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black12, width: 0),
                ),
              ),
              
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: busProvider.bus.length,
              itemBuilder: (context, index) {
                return ActiveBusCard(activeBus: busProvider.bus[index]);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Bottomnav()
    );
  }
}
