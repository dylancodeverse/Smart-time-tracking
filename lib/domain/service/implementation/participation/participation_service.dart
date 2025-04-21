
import 'package:sola/data/interface/datasource/datasource.dart';
import 'package:sola/domain/entity/bus_state.dart';
import 'package:sola/domain/entity/participation/participation.dart';
import 'package:sola/domain/service/interface/cache/i_participation_notpayed_count.dart';
import 'package:sola/domain/service/interface/participation/i_participation.dart';
import 'package:sola/domain/service/interface/participation/i_payment.dart';
import 'package:sola/global/participation.dart';
import 'package:sola/lib/date_helper.dart';
import 'package:sola/lib/price_format.dart';

class ParticipationRepository implements IParticipation {

  DataSource<Participation> participationDatasource; 
  DataSource<BusState> busStateDatasource;
  IParticipationCountCache participationCountServiceCache; 
  IPaymentParticipation paymentParticipationService ;

  ParticipationRepository({required this.participationDatasource, required this.busStateDatasource , required this.participationCountServiceCache , required this.paymentParticipationService});

  @override
  Future<void> saveParticipation(String busId, int amount , String ? comments , int busStateId ) async {
    comments??= "";
    if( amount!= ParticipationVar.amount && comments.trim().isEmpty){
      throw Exception("Raison obligatoire pour montant différent de ${PriceFormat.formatAR(ParticipationVar.amount)}");
    }

    await participationDatasource.insert(Participation(busId: busId, participationDate: Date.getTimestampNow(), amount: amount, comments: comments,
                                   superParticipation: (await paymentParticipationService.getTodayPaymentInfo()).id as int));
    await busStateDatasource.updateAndIgnoreNullColumns(BusState(id: busStateId , participationState: ParticipationVar.okParticipation));
    await participationCountServiceCache.participationRegistered(); 
  }
  
  @override
  Future<void> update(Participation participation) {
    return participationDatasource.updateAndIgnoreNullColumns(participation);
  }
}
