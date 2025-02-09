import 'package:flutter/material.dart';
import 'package:sola/core/theme.dart';
import 'package:sola/widgets/utils/bottomnav.dart';
import 'package:sola/widgets/vehicle/vehicle.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cooperative SOLA'),
        scrolledUnderElevation: 0,
      ),
      body: Column(
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
            child: ListView(
              children: [
                VehicleCard(vehicleName: '2356TQC', driver: 'RAKOTO Zafinirina', status: "En activite", fee: "4535 AR", rating: 4.5, ),
                VehicleCard(vehicleName: '4532TVA', driver: 'Paul Martin',status: "En activite", fee: "24535 AR", rating: 4.5, ),
                VehicleCard(vehicleName: '3388TCA', driver: 'Alice Durand',status: "En activite", fee: "84535 AR", rating: 4.5, ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Bottomnav()
    );
  }
}
