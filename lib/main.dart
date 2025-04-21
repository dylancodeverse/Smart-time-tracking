import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sola/application/data_init/service_init_db.dart';
import 'package:sola/application/injection_helper/bus_state/bus_state_custom_inj.dart';
import 'package:sola/application/injection_helper/depense/inj_depense.dart';
import 'package:sola/application/injection_helper/home_statistics/service_daily_statistic_list.dart';
import 'package:sola/application/injection_helper/participation/inj_stats_participation_with_depense.dart';
import 'package:sola/application/injection_helper/participation/inj_today_participation.dart';
import 'package:sola/application/injection_helper/participation/participation_datasource.dart';
import 'package:sola/application/injection_helper/participation/payment_participation_process_datasource.dart';
import 'package:sola/application/injection_helper/violation/violation_datasource.dart';
// ignore: unused_import
import 'package:sola/data/helper/sharedpreferences/database_reinit.dart';
import 'package:sola/data/interface/datasource/datasource.dart';
import 'package:sola/domain/entity/violation/violation.dart';
import 'package:sola/domain/service/channel/time_auto_event.dart';
import 'package:sola/domain/service/implementation/notification/notification_service.dart';
import 'package:sola/domain/service/implementation/violation/violation_service.dart';
import 'package:sola/domain/service/interface/cache/i_participation_notpayed_count.dart';
import 'package:sola/domain/service/interface/depense/i_depense.dart';
import 'package:sola/domain/service/interface/participation/i_participation.dart';
import 'package:sola/domain/service/interface/participation/i_payment_participation_process_service.dart';
import 'package:sola/domain/service/interface/participation/i_stats_participation_with_depense.dart';
import 'package:sola/domain/service/interface/participation/i_today_participation_lib.dart';
import 'package:sola/domain/service/interface/stats/i_daily_statistic_list_service.dart';
import 'package:sola/presentation/UI/config/theme.dart';
import 'package:sola/presentation/UI/features/summary/summary.dart';
import 'package:sola/presentation/UI/features/queue/arrival/arrival_declaration_screen.dart';
import 'package:sola/presentation/UI/features/queue/assignement/edit_assignement.dart';
import 'package:sola/presentation/UI/features/queue/assignement/radio_assignement.dart';
import 'package:sola/presentation/UI/features/autotime/auto_time.dart';
import 'package:sola/presentation/UI/features/queue/home/home_screen.dart';
import 'package:sola/presentation/UI/features/queue/participation/participation_screen.dart';
import 'package:sola/presentation/UI/widgets/alert/error_modal.dart';
import 'package:sola/presentation/providers_services/arrival_declaration/modal_provider.dart';
import 'package:sola/presentation/providers_services/depense/depense_today.dart';
import 'package:sola/presentation/providers_services/error/error_provider.dart';
import 'package:sola/presentation/providers_services/home/daily_statistic_list_provider.dart';
import 'package:sola/presentation/providers_services/home/search_filter_provider.dart';
import 'package:sola/application/injection_helper/cache/participation_cache.dart';
import 'package:sola/presentation/providers_services/participation/participation_today.dart';
import 'package:sola/presentation/providers_services/payment/payment.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServiceInitdb.initSQFlite(false);
  await GetStorageHelper.initGetStorage(false);
  NotificationService.requestAndroid13Permission();

  final IDailyStatisticListService iDailyStatisticListService = await InjectiondailystatisticList.getStatsService();
  final DataSource<Violation> violationDatasource = await ViolationDatasource.getViolationDatasourceSQFLITE();
  final IPaymentParticipationProcessService iPaymentParticipationProcessService =await ServiceINJPaymentParticipationProcessDatasource.getIPaymentParticipationProcessInstance();
  final  String reference =  await iPaymentParticipationProcessService.getLastReference() ;
  final IParticipationCountCache iParticipationCountCache =  await  ParticipationCache.getParticipationCountRepositoryImplCache() ;
  final IStatsParticipationWithDepense statsParticipationWithDepenseService =  await InjStatsParticipationWithDepense.getStatsParticipationWithDepenseService(); 
  final IDepense iTodayDepense = await InjDepense.getTodayDepenseService();  
  final IDepense iStandardDepense =  await InjDepense.getDepenseService();
  (await BusStateCustomINJ.getBusStateCustomImplAUTO()).verification();
  final IParticipation iParticipation= await ServiceINJParticipation.getIParticipationInstance();
  final ITodayParticipationLib iTodayParticipation = await InjTodayParticipation.getTodayParticipationLibInstance(); 
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DailyStatisticListProvider(iDailyStatisticListService: iDailyStatisticListService)),
        ChangeNotifierProvider(create: (context) => ModalProvider(iViolation: ViolationService(violationDatasource: violationDatasource))),
        ChangeNotifierProvider(create: (context) => RadioAssignmentProvider()),
        ChangeNotifierProvider(create: (context) => FilterProvider(participationCountServiceCache: iParticipationCountCache)),
        ChangeNotifierProvider(create: (context)=> ErrorProvider()),
        ChangeNotifierProvider(create: (context)=> PaymentService(iPaymentParticipationProcessService: iPaymentParticipationProcessService ,reference: reference, iStatsParticipationWithDepense: statsParticipationWithDepenseService
                                                  ,participationCountServiceCache: iParticipationCountCache,)),
        ChangeNotifierProvider(create: (context)=>DepenseToday(depenseTodayService: iTodayDepense, depenseService: iStandardDepense) ),
        ChangeNotifierProvider(create: (context) => ParticipationToday(participationTodayService:iTodayParticipation , participationService:iParticipation )),
      ],
      child: MyAppWithErrorHandling(), // Utilisation d'un Widget custom pour récupérer le contexte
    ),
  );
  // /// Appel différé à `verification()`
  // WidgetsBinding.instance.addPostFrameCallback((_) async {
  // });
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
        // queue module
        '/declaration': (context) => autoTimeEnabled ? ArrivalDeclarationScreen() : AutoTimeRequiredScreen(),
        '/participation': (context) => autoTimeEnabled ? ParticipationScreen() : AutoTimeRequiredScreen(),
        '/edit/assignement': (context) => autoTimeEnabled ? EditAssignement() : AutoTimeRequiredScreen(),
        // payment module
        '/summary': (context) => autoTimeEnabled ? Summary(): AutoTimeRequiredScreen(),
      },
    );
  }
}
