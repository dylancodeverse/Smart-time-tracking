import 'package:sola/data/interface/bus_state_custom/bus_state_custom.dart';
import 'package:sqflite/sqflite.dart';

class BusStateCustomImpl implements BusStateCustom {
  final Database database;
  
  BusStateCustomImpl({required this.database});
  
  @override
  Future<void> update() async {
    await database.update(
      'etat_voitures_actu', // nom de la table
      {
        'etat_pointage': 0,  // statusCheck -> etat_pointage
        'dernier_pointage': null,  // lastCheck -> dernier_pointage
        'estimation_prochaine_action': null,  // nextChangeDatePrevision -> estimation_prochaine_action
        'participation_etat': 0,  // participationState -> participation_etat
      },
    );
  }

  
}