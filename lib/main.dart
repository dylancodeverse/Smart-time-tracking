import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sola/application/data_init/service_init_db.dart';
import 'package:sola/application/injection_helper/bus_state/bus_state_custom_inj.dart';
import 'package:sola/application/injection_helper/home_statistics/service_daily_statistic_list.dart';
import 'package:sola/application/injection_helper/violation/violation_datasource.dart';
// ignore: unused_import
import 'package:sola/data/helper/sharedpreferences/database_reinit.dart';
import 'package:sola/data/interface/datasource/datasource.dart';
import 'package:sola/domain/entity/violation/violation.dart';
import 'package:sola/domain/service/channel/time_auto_event.dart';
import 'package:sola/domain/service/implementation/notification/notification_service.dart';
import 'package:sola/domain/service/implementation/violation/violation_service.dart';
import 'package:sola/domain/service/interface/stats/i_daily_statistic_list_service.dart';
import 'package:sola/presentation/UI/config/theme.dart';
import 'package:sola/presentation/UI/features/arrival/arrival_declaration_screen.dart';
import 'package:sola/presentation/UI/features/assignement/edit_assignement.dart';
import 'package:sola/presentation/UI/features/assignement/radio_assignement.dart';
import 'package:sola/presentation/UI/features/autotime/auto_time.dart';
import 'package:sola/presentation/UI/features/home/home_screen.dart';
import 'package:sola/presentation/UI/features/participation/participation_screen.dart';
import 'package:sola/presentation/UI/widgets/alert/error_modal.dart';
import 'package:sola/presentation/providers/arrival_declaration/modal_provider.dart';
import 'package:sola/presentation/providers/error/error_provider.dart';
import 'package:sola/presentation/providers/home/daily_statistic_list_provider.dart';
import 'package:sola/presentation/providers/home/search_filter_provider.dart';
import 'package:sola/application/injection_helper/cache/participation_cache.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServiceInitdb.initSQFlite(false);
  // await SharedPreferencesHelper.resetSharedPreferences();
  NotificationService.requestAndroid13Permission();

  final IDailyStatisticListService iDailyStatisticListService = await InjectiondailystatisticList.getStatsService();
  final DataSource<Violation> violationDatasource = await ViolationDatasource.getViolationDatasourceSQFLITE();
  // verification si mis a jour requis partie manuelle
  // (await BusStateCustomINJ.getBusStateCustomImpl()).verification();
  // verification tous les jours en arriere plan
  (await BusStateCustomINJ.getBusStateCustomImplAUTO()).verification();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DailyStatisticListProvider(iDailyStatisticListService: iDailyStatisticListService)),
        ChangeNotifierProvider(create: (context) => ModalProvider(iViolation: ViolationService(violationDatasource: violationDatasource))),
        ChangeNotifierProvider(create: (context) => RadioAssignmentProvider()),
        ChangeNotifierProvider(create: (context) => FilterProvider(participationCountServiceCache: ParticipationCache.getParticipationCountRepositoryImplCache())),
        ChangeNotifierProvider(create: (context)=> ErrorProvider())
      ],
      child: MyAppWithErrorHandling(), // Utilisation d'un Widget custom pour récupérer le contexte
    ),
  );
}

class MyAppWithErrorHandling extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final errorProvider = Provider.of<ErrorProvider>(context, listen: false);

    PlatformDispatcher.instance.onError = (error, stackTrace) {
      errorProvider.setError(error.toString(), stackTrace);
      return true;
    };

    return MaterialApp(
      home: Consumer<ErrorProvider>(
        builder: (context, errorProvider, child) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (errorProvider.lastError != null) {
              ErrorActionModal.show(
                context,
                title: "Erreur détectée",
                description: errorProvider.lastError.toString(),
              );

              // Réinitialiser l'erreur après affichage pour éviter plusieurs modals
              errorProvider.clearError();
            }
          });

          return MyApp(); // Ton widget principal
        },
      ),
    );
  }
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool autoTimeEnabled = true;

  @override
  void initState() {
    super.initState();
    _checkAutoTime();
    
    // Ecouter les changements en temps réel sur l'heure automatique
    TimeAutoEvent.timeAutoStream.listen((event) {
      setState(() {
        autoTimeEnabled = event; // Mise à jour de l'état de l'heure automatique
      });
    });
  }

  Future<void> _checkAutoTime() async {
    const platform = MethodChannel('com.example.sola/settings');
    final bool isAutoTimeEnabled = await platform.invokeMethod('isAutoTimeEnabled');
    setState(() {
      autoTimeEnabled = isAutoTimeEnabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Nous avons déplacé la logique de `MaterialApp` en dehors de `build`
    return MaterialApp(
      title: 'SOLA',
      theme: AppTheme.lightTheme,
      home: autoTimeEnabled ? HomeScreen() : AutoTimeRequiredScreen(),  // Écran conditionnel en fonction de `autoTimeEnabled`
      initialRoute: '/',
      routes: {
        '/declaration': (context) => autoTimeEnabled ? ArrivalDeclarationScreen() : AutoTimeRequiredScreen(),
        '/participation': (context) => autoTimeEnabled ? ParticipationScreen() : AutoTimeRequiredScreen(),
        '/edit/assignement': (context) => autoTimeEnabled ? EditAssignement() : AutoTimeRequiredScreen(),
      },
    );
  }
}
