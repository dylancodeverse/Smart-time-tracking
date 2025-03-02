import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sola/application/data_init/service_init_db.dart';
import 'package:sola/application/injection_helper/home_statistics/service_daily_statistic_list.dart';
import 'package:sola/application/injection_helper/violation/violation_datasource.dart';
import 'package:sola/data/interface/datasource/datasource.dart';
import 'package:sola/domain/entity/violation/violation.dart';
import 'package:sola/domain/service/implementation/violation/violation_service.dart';
import 'package:sola/domain/service/interface/stats/i_daily_statistic_list_service.dart';
import 'package:sola/presentation/UI/config/theme.dart';
import 'package:sola/presentation/UI/features/arrival/arrival_declaration_screen.dart';
import 'package:sola/presentation/UI/features/assignement/edit_assignement.dart';
import 'package:sola/presentation/UI/features/assignement/radio_assignement.dart';
import 'package:sola/presentation/UI/features/home/home_screen.dart';
import 'package:sola/presentation/UI/features/participation/participation_screen.dart';
import 'package:sola/presentation/providers/arrival_declaration/modal_provider.dart';
import 'package:sola/presentation/providers/home/daily_statistic_list_provider.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await ServiceInitdb.initSQFlite(false);
  final IDailyStatisticListService iDailyStatisticListService = await InjectiondailystatisticList.getStatsService();
  final DataSource<Violation> violationDatasource = await ViolationDatasource.getViolationDatasourceSQFLITE();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DailyStatisticListProvider(iDailyStatisticListService: iDailyStatisticListService)), // 🔹 Gestion de la liste
        ChangeNotifierProvider(create: (context)=>ModalProvider(iViolation: ViolationService(violationDatasource:violationDatasource ))),
        ChangeNotifierProvider(create: (context)=>RadioAssignmentProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SOLA',
      theme: AppTheme.lightTheme,
      home: HomeScreen(),
      initialRoute: '/', // Route initiale
      routes: {
        // '/': (context) => HomeScreen(),
        '/declaration': (context) => ArrivalDeclarationScreen(), 
        '/participation':(context) => ParticipationScreen(),
        '/edit/assignement':(context)=> EditAssignement(),
      },

    );
  }
}
