import 'package:sola/application/injection_helper/depense/inj_depense.dart';
import 'package:sola/domain/entity/depense/depense.dart';
import 'package:sola/domain/service/interface/depense/i_depense.dart';
import 'package:sola/lib/price_format.dart';
import 'package:sola/presentation/providers_services/payment/payment.dart';

class DepenseUIService  {
  late IDepense depenseService ;
  late PaymentService paymentService ;

  Future< void> init(PaymentService p) async{
    depenseService = await InjDepense.getDepenseService();
    paymentService =p ;
  }

  Future< void> confirmDepense(String amount, String comments) async{
    int amount2 = PriceFormat.getPrice(amount, 100,20000); ;         
    await depenseService.save(Depense(amount:amount2 ,reason: comments));    
    paymentService.refreshData();
  }

}