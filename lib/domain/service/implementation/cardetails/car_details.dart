import 'package:sola/data/helper/sqflite/sqflite_database.dart';
import 'package:sqflite/sqflite.dart';

  class CarDetailsService {
  Future<List<double>> getCarDetailsData(String busId, int departure) async {
    final Database db = await SqfliteDatabaseHelper().database;

    // 1. Conversion en DateTime
    DateTime departureDateTime = DateTime.fromMillisecondsSinceEpoch(departure);
    
    // 2. Extraction de l'heure actuelle en minutes depuis minuit
    int departureInMinutes = departureDateTime.hour * 60 + departureDateTime.minute ;

    // 3. Calcul de la plage horaire sociale
    int socialSlot = () {
      if (departureInMinutes >= 450 && departureInMinutes <= 540) {
        return 1; // Embauche : 07:30 -> 09:00
      } else if (departureInMinutes >= 990 && departureInMinutes <= 1080) {
        return 2; // Débauche : 16:30 -> 18:00
      } else {
        return 0; // Hors trafic
      }
    }();

    // 4. Calcul du jour de la semaine (0 = lundi, ..., 6 = dimanche)
    int dayOfWeek = (departureDateTime.weekday - 1) % 7;

    // 5. Récupération des données du véhicule
    final List<Map<String, dynamic>> results = await db.query(
      'vehicules',
      columns: [
        'puissance_chevaux',
        'consommation_l_100km',
        'poids_kg',
        'longueur_mm',
        'largeur_mm',
        'hauteur_mm',
        'annee_lancement',
      ],
      where: 'id = ?',
      whereArgs: [busId],
      limit: 1,
    );

    if (results.isEmpty) {
      throw Exception('Aucune donnée trouvée pour le bus $busId');
    }

    final data = results.first;

    return [
      departureInMinutes.toDouble(),                         // departure en minutes depuis minuit
      (data['puissance_chevaux'] ?? 0).toDouble(),           // puissance
      (data['consommation_l_100km'] ?? 0).toDouble(),        // conso
      (data['poids_kg'] ?? 0).toDouble(),                    // poids
      (data['longueur_mm'] ?? 0).toDouble(),                 // longueur
      (data['largeur_mm'] ?? 0).toDouble(),                  // largeur
      (data['hauteur_mm'] ?? 0).toDouble(),                  // hauteur
      (data['annee_lancement'] ?? 2018).toDouble(),          // annee (utilise la valeur de la DB)
      socialSlot.toDouble(),                                 // plage horaire sociale
      dayOfWeek.toDouble(),                                  // jour semaine
    ];
  }
}