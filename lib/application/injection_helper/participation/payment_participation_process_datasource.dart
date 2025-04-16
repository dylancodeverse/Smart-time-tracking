import 'package:sola/application/injection_helper/participation/payment_participation_datasource.dart';
import 'package:sola/domain/service/implementation/participation/payment_participation_process_service.dart';
import 'package:sola/domain/service/interface/participation/i_payment_participation_process_service.dart';

class ServiceINJPaymentParticipationProcessDatasource {
    
  static Future<IPaymentParticipationProcessService> getIPaymentParticipationProcessInstance() async {
    return PaymentParticipationProcessService(paymentParticipationDatasourceSQL: await ServiceINJPaymentParticipation.getPaymentParticipationDatasource(),
     paymentParticipationDatasourceCache:  ServiceINJPaymentParticipation.getPaymentParticipationDatasourceCache());
  }
}