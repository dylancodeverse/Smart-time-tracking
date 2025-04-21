
import 'package:sola/data/interface/datasource/datasource.dart';
import 'package:sola/domain/entity/participation/payment.dart';
import 'package:sola/domain/excpetion/update_exception.dart';
import 'package:sola/domain/service/interface/participation/i_payment.dart';

class PaymentParticipationService implements IPaymentParticipation {
  DataSource<PaymentParticipation> paymentParticipationDatasource ;

  PaymentParticipationService({required this.paymentParticipationDatasource});

  @override
  Future<void> save(PaymentParticipation participation) async {
    dynamic id = await paymentParticipationDatasource.insert(participation);
    try{
      participation.id =id ;
    // ignore: empty_catches
    }catch(e){
      // id n'est pas int mais ca passe ca car on gere les caches
    }
  }


  @override
  Future<void> update(PaymentParticipation participation) async{
    await paymentParticipationDatasource.update(participation);
  }
  
  @override
  Future<PaymentParticipation> getTodayPaymentInfo() async{
    try {
      return (await paymentParticipationDatasource.getAll())[0];
    } catch (e) {
      throw UpdateException();
    }
  }
}
