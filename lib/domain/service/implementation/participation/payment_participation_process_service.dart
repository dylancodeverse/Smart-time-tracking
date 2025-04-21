import 'package:sola/data/interface/datasource/datasource.dart';
import 'package:sola/domain/entity/participation/payment.dart';
import 'package:sola/domain/excpetion/update_exception.dart';
import 'package:sola/domain/service/interface/participation/i_payment_participation_process_service.dart';
import 'package:sola/lib/date_helper.dart';

class PaymentParticipationProcessService implements IPaymentParticipationProcessService {

  DataSource<PaymentParticipation> paymentParticipationDatasourceSQL;
  DataSource<PaymentParticipation> paymentParticipationDatasourceCache;

  PaymentParticipationProcessService({required this.paymentParticipationDatasourceSQL, required this.paymentParticipationDatasourceCache, 
  });

  @override
  Future<int> getLastId() async{
    List<PaymentParticipation> list=  await(paymentParticipationDatasourceCache.getAll());
    try{
      return list[0].id as int; 

    }catch(e){
      throw UpdateException();
    }
  }

  

  @override
  Future<void> updatePayment(String reference, ) async{

    int id=  await getLastId();
    PaymentParticipation paymentParticipation = PaymentParticipation(participationDate: Date.getTimestampNow(),reference: reference,id: id);

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