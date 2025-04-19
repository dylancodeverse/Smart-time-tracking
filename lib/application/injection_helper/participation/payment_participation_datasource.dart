import 'package:sola/application/entity_helper/participation/payment_participation_helper.dart';
import 'package:sola/data/helper/sharedpreferences/database_reinit.dart';
import 'package:sola/data/helper/sqflite/sqflite_database.dart';
import 'package:sola/data/implementation/cache/get_storage_datasource.dart';
import 'package:sola/data/implementation/sqflite/sqflite_datasource.dart';
import 'package:sola/data/interface/datasource/datasource.dart';
import 'package:sola/domain/entity/participation/payment.dart';
import 'package:sola/domain/service/implementation/participation/payment_participation_service.dart';
import 'package:sola/domain/service/interface/participation/i_payment.dart';

class ServiceINJPaymentParticipation {

  static Future<DataSource<PaymentParticipation>> getPaymentParticipationDatasource() async{
    return SQLiteDataSource(database: await SqfliteDatabaseHelper().database, 
    tableName: "PAYMENTPARTICIPATION", fromMap: PaymentParticipationHelper.fromMap, toMap: PaymentParticipationHelper.toMap);
  }

  static Future<DataSource<PaymentParticipation>> getPaymentParticipationDatasourceCache() async{
    GetStorageDataSource<PaymentParticipation>lastUpdateDataSource = GetStorageDataSource<PaymentParticipation>(
        key: "payment_participation_cache",
        fromJson: PaymentParticipationHelper.fromMap,
        toJson: (update) => PaymentParticipationHelper.toMap(update),
        box: await GetStorageHelper.getStorage()
      );
    return lastUpdateDataSource;
  }

  static Future<IPaymentParticipation> getIPaymentParticipationInstance() async {
    return PaymentParticipationService(paymentParticipationDatasource:await getPaymentParticipationDatasource(),);
  }

  static Future<IPaymentParticipation> getIPaymentParticipationInstanceCache() async{
    return PaymentParticipationService(paymentParticipationDatasource: await getPaymentParticipationDatasourceCache(),);
  }

}