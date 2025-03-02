import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sola/application/injection_helper/assignement/assignement_datasource.dart';
import 'package:sola/domain/entity/assignement.dart';
import 'package:sola/presentation/UI/config/color_checker.dart';
import 'package:sola/presentation/UI/config/theme.dart';
import 'package:sola/presentation/UI/features/assignement/radio_assignement.dart';
import 'package:sola/presentation/UI/features/assignement/radio.dart';
import 'package:sola/presentation/UI/features/home/bus_card/bus_details.dart';
import 'package:sola/presentation/UI/features/home/bus_card/bus_info_header.dart';
import 'package:sola/presentation/UI/widgets/bottomnav.dart';
import 'package:sola/presentation/providers/home/daily_statistic_provider.dart';

class EditAssignement extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final monObjet = ModalRoute.of(context)!.settings.arguments as DailyStatisticProvider;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(AppTheme.appName),
        scrolledUnderElevation: 0,
      ),
      body: SimpleCardBUS(activeBusProvider: monObjet), 

      bottomNavigationBar: Bottomnav(),
    );
  }
  
} 




class SimpleCardBUS extends StatefulWidget {
  final DailyStatisticProvider activeBusProvider;

  const SimpleCardBUS({super.key, required this.activeBusProvider});

  @override
  _SimpleCardBUSState createState() => _SimpleCardBUSState();
}

class _SimpleCardBUSState extends State<SimpleCardBUS> {

  @override
  void initState() {
    super.initState();
    Future.microtask(()async =>
        Provider.of<RadioAssignmentProvider>(context, listen: false).initDatas(widget.activeBusProvider.bus,await AssignementDatasource.getIAssignement(widget.activeBusProvider.bus.busID)));
  }
  



  void onValidate( BuildContext context , RadioAssignmentProvider myProvider)async{
    widget.activeBusProvider.setAssignement(context ,myProvider.selectedItem.objectInit as Assignment);

  }




  @override
  Widget build(BuildContext context) {
    return 
    Consumer<RadioAssignmentProvider>(
      builder: (context, myProvider, child) {  
        return Card(
          color: AppTheme.cardColor,
          margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // En-tête du bus
                BusInfoHeader(
                  pilotCompleteName: widget.activeBusProvider.bus.driverCompleteName,
                  registrationNumber: widget.activeBusProvider.bus.registrationNumber,
                ),
                const SizedBox(height: 12),

                // Détails du bus
                BusDetails(
                  libAmount: widget.activeBusProvider.bus.getLibAmount(),
                  round: widget.activeBusProvider.bus.getLibRound(),
                  status: widget.activeBusProvider.bus.libStatus(),
                  statusColor: ColorLib.getColorByStatus(widget.activeBusProvider.bus.status),
                  nextActionEstimation: widget.activeBusProvider.bus.nextActionEstimation,
                ),
                const SizedBox(height: 16),


                SingleSelectRadio(),


                const SizedBox(height: 16),

                // Bouton de validation
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      onValidate(context,myProvider);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.darkPrimary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text('Enregistrer', style: TextStyle(color: AppTheme.scaff)),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );   
  }
}
