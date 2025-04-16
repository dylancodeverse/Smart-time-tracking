import 'package:sola/data/interface/datasource/datasource.dart';
import 'package:sola/domain/entity/participation/payment.dart';
import 'package:sola/domain/service/interface/participation/i_payment_participation_process_service.dart';
import 'package:sola/lib/date_helper.dart';

class PaymentParticipationProcessService implements IPaymentParticipationProcessService {

  DataSource<PaymentParticipation> paymentParticipationDatasourceSQL;
  DataSource<PaymentParticipation> paymentParticipationDatasourceCache;

  PaymentParticipationProcessService({required this.paymentParticipationDatasourceSQL, required this.paymentParticipationDatasourceCache});

  @override
  Future<int> getLastId() async{
    List<PaymentParticipation> list=  await(paymentParticipationDatasourceCache.getAll());
    try{
      print(list[0].participationDate);
      return list[0].id as int; 

    }catch(e){
      print(e);
      throw Exception("Une mise à jour est necessaire pour poursuivre cette action");
    }
  }

  

  @override
  Future<void> updatePayment(String reference, ) async{
    int id=  await getLastId();
    int montant =3434;
    PaymentParticipation paymentParticipation = PaymentParticipation(participationDate: Date.getTimestampNow(),reference: reference,id: id, montantTotal: montant);

    // normalement tokony mbola misy calcul ana depense
    await paymentParticipationDatasourceSQL.updateAndIgnoreNullColumns(paymentParticipation);
    // cache
    await paymentParticipationDatasourceCache.insert(paymentParticipation);
  }
  
  @override
  Future<String> getLastReference() async{
    List<PaymentParticipation> list=  await(paymentParticipationDatasourceCache.getAll());
    try{
        return list[0].reference as String ;

    }catch(e){ // out of bound exception 
      return "";
    }
  }
  
}