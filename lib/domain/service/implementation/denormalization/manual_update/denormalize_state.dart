import 'package:sola/data/interface/bus_state_custom/bus_state_custom.dart';
import 'package:sola/domain/entity/participation/payment.dart';
import 'package:sola/domain/service/implementation/notification/notification_service.dart';
import 'package:sola/domain/service/interface/cache/i_last_update_repo.dart';
import 'package:sola/domain/service/interface/cache/i_participation_notpayed_count.dart';
import 'package:sola/domain/service/interface/denormalization/i_denormalize_state.dart';
import 'package:sola/domain/service/interface/participation/i_payment.dart';
import 'package:sola/lib/date_helper.dart';

class DenormalizeState implements IDenormalizeState {

// depend de la partie data layer pour que les logiques metiers sont les seules choses ici xd
  BusStateCustom busStateCustom;

  LastUpdateRepository lastUpdateRepository;
  IParticipationCountCache participationCountCache ;
  // instance de service payment utilisant sqflite
  IPaymentParticipation paymentParticipationService ;
  // instance de service payment utilisant cache
  IPaymentParticipation paymentParticipationServiceCache;

  DenormalizeState({required this.busStateCustom, required this.lastUpdateRepository , required this.participationCountCache,required this.paymentParticipationService, required this.paymentParticipationServiceCache});

  @override
  Future<void> verification()  async{
    bool needsUpdateBus = await lastUpdateRepository.isUpdateNeeded();
    bool updateNeededParticipationState = await participationCountCache.isUpdateNeeded();
    NotificationService.initialize(); // 🔔 Initialisation des notifications
    if (needsUpdateBus) {
      // required task
      await busStateCustom.update();
      await lastUpdateRepository.save(DateTime.now());
      // initialise payment donne (date du jour , generation de cle )
      PaymentParticipation paymentParticipation = PaymentParticipation(montantTotal: 0,participationDate: Date.getTimestampNow());
      await paymentParticipationService.save(paymentParticipation);     
      // sauvegarder la cle generee comme cache || utile pour les participation de chaque bus
      await paymentParticipationServiceCache.save(paymentParticipation);
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