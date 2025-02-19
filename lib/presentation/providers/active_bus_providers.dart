import 'package:flutter/material.dart';
import 'package:sola/data/models/pointage/pointage.dart';
import 'package:sola/data/repositories/etat_voiture_repository.dart';
import 'package:sola/data/repositories/pointages_repository.dart';
import 'package:sola/lib/date.dart';
import '../../data/models/active_bus.dart';

class ActiveBusProvider with ChangeNotifier {
  // ignore: prefer_final_fields
  ActiveBus _activeBus;
  
  final PointagesRepository pointagesRepository  ;

  ActiveBusProvider(this._activeBus, this.pointagesRepository);

  ActiveBus get activeBus => _activeBus;



  void demarrerOuTerminerTour(){
    _activeBus.isDepart ? terminerTour() : demarrerTour();
  }

  Future<int> updateEtatDB(int etat , int dernierPointage) async{
    EtatVoitureRepository etatVoitureRepository = EtatVoitureRepository();
    activeBus.bus.etatVoiture.etatPointage=etat;
    activeBus.bus.etatVoiture.dernierPointage=dernierPointage ;
    return etatVoitureRepository.updateEtatVoiture(activeBus.bus.etatVoiture);
  }

  void demarrerTour() async{
    // transactionnel
    Pointages pointages= Pointages.depart(_activeBus.bus.affectationId,Date.getTimestampNow(),_activeBus.bus.vehiculeId);
    int pointagesID = await pointagesRepository.saveBusPointages(pointages);
    await updateEtatDB(1,pointagesID);
    notifyListeners();
  }



  void terminerTour() async{
    Pointages pointages = Pointages.arrivee(idVehicule: _activeBus.bus.vehiculeId, 
                          montant: 2000, dateArrivee: Date.getTimestampNow(),id: _activeBus.bus.etatVoiture.dernierPointage);
    pointages.id =_activeBus.bus.etatVoiture.dernierPointage as int ;
  print('date ${pointages.dateArrivee}');
    await pointagesRepository.updateBusPointages(pointages);
    await updateEtatDB(0, _activeBus.bus.etatVoiture.dernierPointage as int);
    
    _activeBus.nombreTours+=1;
    _activeBus.totalMontant+= pointages.montant as int ;
    
    notifyListeners();
  }
}