import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sola/application/injection_helper/check/service_arrival_declaration.dart';
import 'package:sola/presentation/UI/config/color_checker.dart';
import 'package:sola/presentation/UI/config/theme.dart';
import 'package:sola/presentation/UI/features/home/bus_card/bus_details.dart';
import 'package:sola/presentation/UI/features/home/bus_card/bus_info_header.dart';
import 'package:sola/presentation/UI/widgets/bottomnav.dart';
import 'package:sola/presentation/UI/widgets/gesture_detector_modal.dart';
import 'package:sola/presentation/UI/widgets/input_field.dart';
import 'package:sola/presentation/UI/widgets/multi_select.dart';
import 'package:sola/presentation/model/stats/daily_statistic.dart';
import 'package:sola/presentation/providers/arrival_declaration/declaration.dart';
import 'package:sola/presentation/providers/arrival_declaration/modal_provider.dart';

class ArrivalDeclarationScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final monObjet = ModalRoute.of(context)!.settings.arguments as DailyStatisticView;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(AppTheme.appName),
        scrolledUnderElevation: 0,
      ),
      body: SimpleCardBUS(activeBus: monObjet), 

      bottomNavigationBar: Bottomnav(),
    );
  }
  
} 




class SimpleCardBUS extends StatefulWidget {
  final DailyStatisticView activeBus;

  const SimpleCardBUS({super.key, required this.activeBus});

  @override
  _SimpleCardBUSState createState() => _SimpleCardBUSState();
}

class _SimpleCardBUSState extends State<SimpleCardBUS> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<ModalProvider>(context, listen: false).initDatas(widget.activeBus.busID));
  }
  
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();

  void  _showMultiSelect() async {
    // a list of selectable items
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect();
      },
    );
  }

  void onValidate(ModalProvider myProvider)async{
    ArrivalDeclaration arrivalDeclaration= await ServiceArrivalDeclaration.getArrivalDeclaration();
        
    arrivalDeclaration.declaration(widget.activeBus, int.parse(_amountController.text.trim()), _commentController.text, myProvider.getCheckedViolation() , context);
  }




  @override
  Widget build(BuildContext context) {
    return 
    Consumer<ModalProvider>(
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
                  pilotCompleteName: widget.activeBus.driverCompleteName,
                  registrationNumber: widget.activeBus.registrationNumber,
                ),
                const SizedBox(height: 12),

                // Détails du bus
                BusDetails(
                  libAmount: widget.activeBus.getLibAmount(),
                  round: widget.activeBus.getLibRound(),
                  status: widget.activeBus.libStatus(),
                  statusColor: ColorLib.getColorByStatus(widget.activeBus.status),
                  nextActionEstimation: widget.activeBus.nextActionEstimation,
                ),
                const SizedBox(height: 14),

                // Champ de saisie pour le montant
                InputField(
                  controller: _amountController,
                  hintText: "Saisir le montant",
                  icon: Icons.attach_money,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10),

                // Champ de saisie pour les commentaires
                InputField(
                  controller: _commentController,
                  hintText: "Ajouter un commentaire",
                  icon: Icons.comment,
                  maxLines: 3,
                ),
                const SizedBox(height: 10),

                // Liste déroulante pour sélectionner une violation
                GestureDetectorModal(
                  text: myProvider.modalButtonText,
                  onTap: () {
                    _showMultiSelect();
                  },
                  icon: Icons.list, // Icône personnalisée
                  backgroundColor:Colors.grey[200]!,
                  textColor:Colors.black87, // Texte bleu foncé
                ),


                const SizedBox(height: 16),

                // Bouton de validation
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      onValidate(myProvider);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.darkPrimary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text('Valider', style: TextStyle(color: AppTheme.scaff)),
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
