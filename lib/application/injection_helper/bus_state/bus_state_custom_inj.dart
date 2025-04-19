import 'package:sola/application/injection_helper/cache/last_update_cache.dart';
import 'package:sola/application/injection_helper/cache/participation_cache.dart';
import 'package:sola/application/injection_helper/participation/payment_participation_datasource.dart';
import 'package:sola/data/helper/sqflite/sqflite_database.dart';
import 'package:sola/data/implementation/bus_state_custom/bus_state_custom.dart';
import 'package:sola/domain/service/implementation/cache/last_update_repo.dart';
import 'package:sola/domain/service/implementation/denormalization/manual_update/denormalize_state.dart';
import 'package:sola/domain/service/implementation/denormalization/background_update/denormalize_state_auto.dart';
import 'package:sola/domain/service/interface/participation/i_payment.dart';

class BusStateCustomINJ {
  static Future<DenormalizeState> getBusStateCustomImpl() async{
    LastUpdateRepositoryImpl lastUpdateRepositoryImpl= await LastUpdateCache.getLastUpdateRepositoryImpl();
    BusStateCustomImpl busStateCustomImpl= BusStateCustomImpl(database: await SqfliteDatabaseHelper().database );
    // instance de service payment utilisant sqflite
    IPaymentParticipation paymentParticipationService = await ServiceINJPaymentParticipation.getIPaymentParticipationInstance();
    // instance de service payment utilisant cache
    IPaymentParticipation paymentParticipationServiceCache= await ServiceINJPaymentParticipation.getIPaymentParticipationInstanceCache();

    return DenormalizeState (busStateCustom: busStateCustomImpl,lastUpdateRepository: lastUpdateRepositoryImpl
    ,participationCountCache:  await ParticipationCache.getParticipationCountRepositoryImplCache() ,
    paymentParticipationService: paymentParticipationService,
    paymentParticipationServiceCache: paymentParticipationServiceCache
    );      
  }
  static Future<DenormalizeStateAuto> getBusStateCustomImplAUTO() async{
    return DenormalizeStateAuto ();
  }

}