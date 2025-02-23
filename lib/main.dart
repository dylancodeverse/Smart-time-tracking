import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sola/application/data_init/service_init_db.dart';
import 'package:sola/application/home_statistics/service_daily_statistic_list.dart';
import 'package:sola/domain/service/interface/i_daily_statistic_list_service.dart';
import 'package:sola/presentation/UI/config/theme.dart';
import 'package:sola/presentation/UI/features/home/home_screen.dart';
import 'package:sola/presentation/providers/home/daily_statistic_list_provider.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await ServiceInitdb.initSQFlite(false);
  final IDailyStatisticListService iDailyStatisticListService = await InjectiondailystatisticList.getStatsService();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DailyStatisticListProvider(iDailyStatisticListService: iDailyStatisticListService)), // 🔹 Gestion de la liste
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
    );
  }
}
