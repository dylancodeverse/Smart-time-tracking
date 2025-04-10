import 'package:flutter/material.dart';
import 'package:sola/application/injection_helper/cache/last_update_cache.dart';
import 'package:sola/application/injection_helper/cache/participation_cache.dart';
import 'package:sola/data/helper/sqflite/sqflite_database.dart';
import 'package:sola/data/implementation/bus_state_custom/bus_state_custom.dart';
import 'package:sola/data/interface/bus_state_custom/bus_state_custom.dart';
import 'package:sola/domain/service/implementation/cache/participation_notpayed_count.dart';
import 'package:sola/domain/service/implementation/notification/notification_service.dart';
import 'package:sola/domain/service/interface/cache/i_last_update_repo.dart';
import 'package:sola/domain/service/interface/denormalization/i_denormalize_state.dart';
import 'package:workmanager/workmanager.dart';

class DenormalizeStateAuto implements IDenormalizeState {
  static const String taskName = "updateTask";
  static const String lastUpdateKey = "last_update";
  
  


  DenormalizeStateAuto();

  @override
  Future<void> verification() async {
    await Workmanager().initialize(callbackDispatcher, isInDebugMode: false);
    await _scheduleUpdateFrom7AMWeekdays();
  }

  Future<void> _scheduleUpdateFrom7AMWeekdays() async {
    await Workmanager().registerPeriodicTask(
      taskName,
      "update_database",
      frequency: Duration(minutes: 15), // Répétition toutes les 15 minutes
      initialDelay: _getInitialDelay(), // Attente jusqu'à 7h
    );
  }

  Duration _getInitialDelay() {
    final now = DateTime.now();
    final today7AM = DateTime(now.year, now.month, now.day, 7, 0, 0);

    if (now.weekday >= 6) { 
      // Si c'est samedi (6) ou dimanche (7), attendre lundi 7h
      final daysToWait = 8 - now.weekday; 
      final nextMonday = today7AM.add(Duration(days: daysToWait));
      return nextMonday.difference(now);
    }

    return now.isBefore(today7AM) ? today7AM.difference(now) : Duration.zero;
  }
  
}


void callbackDispatcher() async{
  WidgetsFlutterBinding.ensureInitialized(); // 💡  Cette ligne garantit que Flutter initialise ses services natifs dans l'isolate en arrière-plan avant d'effectuer toute opération nécessitant MethodChannel (comme accéder à la base de données SQLite).

  BusStateCustom busStateCustom = BusStateCustomImpl(database: await SqfliteDatabaseHelper().database );
  LastUpdateRepository lastUpdateRepository =  LastUpdateCache.getLastUpdateRepositoryImpl();
  ParticipationCountCache participationCountCache = ParticipationCache.getParticipationCountRepositoryImplCache();

  Workmanager().executeTask((task, inputData) async {
    final now = DateTime.now();
       
    if (now.weekday == 6 || now.weekday == 7) {
      return Future.value(true); // Rien le week-end
    }
         
    bool needsUpdateBus = await lastUpdateRepository.isUpdateNeeded();
    bool alertState = await participationCountCache.isUpdateNeeded();
    if (needsUpdateBus) {
      NotificationService.initialize(); // 🔔 Initialisation des notifications
      // partie reinitialisation etat des bus 
      await busStateCustom.update();
      await lastUpdateRepository.save(DateTime.now());
      // 💡 Afficher une notification après mise à jour

    }
    if(alertState){
      // partie reinitialisation etat des comptes de participation (pour les alertes)
      await participationCountCache.reInitCount();
    }

    if(needsUpdateBus||alertState){
      await NotificationService.showNotification(
        title: 'Mise à jour terminée',
        body: 'Les données ont été mises à jour avec succès.',
      );
            // Une fois la mise à jour réussie, on annule la répétition
      await Workmanager().cancelByUniqueName(DenormalizeStateAuto.taskName);
    }
    return Future.value(true);
  });
  
}
