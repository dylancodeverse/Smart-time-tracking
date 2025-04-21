import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sola/domain/entity/depense/depense.dart';
import 'package:sola/domain/service/interface/depense/i_depense.dart';
import 'package:sola/presentation/providers_services/payment/payment.dart';

class DepenseToday extends ChangeNotifier {
  IDepense depenseTodayService ;
  IDepense depenseService;

  DepenseToday({required this.depenseTodayService , required this.depenseService});

  Future<List<Depense>> getAllTodayDepense() async{
    return await depenseTodayService.getAll();
  }
  Future<void> updateDepense(Depense depense , BuildContext context) async{
    await depenseService.update(depense);
    await Provider.of<PaymentService>(context, listen: false).refreshData();
    notifyListeners();

  }

}