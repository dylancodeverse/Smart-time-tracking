import 'package:sola/data/interface/bus_state_custom/bus_state_custom.dart';
import 'package:sola/domain/service/implementation/notification/notification_service.dart';
import 'package:sola/domain/service/interface/cache/i_last_update_repo.dart';
import 'package:sola/domain/service/interface/cache/i_participation_notpayed_count.dart';
import 'package:sola/domain/service/interface/denormalization/i_denormalize_state.dart';

class DenormalizeState implements IDenormalizeState {

// depend de la partie data layer pour que les logiques metiers sont les seules choses ici xd
  BusStateCustom busStateCustom;

  LastUpdateRepository lastUpdateRepository;
  IParticipationCountCache participationCountCache ;


  DenormalizeState({required this.busStateCustom, required this.lastUpdateRepository , required this.participationCountCache});

  @override
  Future<void> verification()  async{
    bool needsUpdateBus = await lastUpdateRepository.isUpdateNeeded();
    bool updateNeededParticipationState = await participationCountCache.isUpdateNeeded();
    NotificationService.initialize(); // 🔔 Initialisation des notifications
    if (needsUpdateBus) {
      // required task
      await busStateCustom.update();
      await lastUpdateRepository.save(DateTime.now());
    }
    if (updateNeededParticipationState) {
      await participationCountCache.reInitCount();
    }
    if (updateNeededParticipationState||needsUpdateBus) {
      // 💡 Afficher une notification après mise à jour
      await NotificationService.showNotification(
        title: 'Mise à jour terminée',
        body: 'Les données ont été mises à jour avec succès.',
      );      
    }
  }
}