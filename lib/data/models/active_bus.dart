import 'package:intl/intl.dart';
import 'package:sola/data/models/bus.dart';

class ActiveBus {
  int nombreTours ;
  int totalMontant ;
  Bus bus ;
  ActiveBus({
    required this. bus,
    required this.nombreTours,
    required this.totalMontant
  });

  String getLibMontant(){
     var formatter = NumberFormat('#,##0');

    // Formater le nombre
     String formattedNumber = formatter.format(totalMontant);
     return "$formattedNumber AR";
  }

  String getLibNombreTours () => "Tours: $nombreTours";

  factory ActiveBus.fromMap(Map<String, dynamic> map) {
    return ActiveBus(bus: Bus.fromMap(map),
     nombreTours: map['nombre_tours'],
     totalMontant: map['total_montant']);
  }   

}