import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sola/presentation/providers_services/home/daily_statistic_list_provider.dart';

class UpdateButton extends StatelessWidget {

  const UpdateButton({super.key, });

  @override
  Widget build(BuildContext context) {
    final busProvider = Provider.of<DailyStatisticListProvider>(context, listen: false);

    return Row(
      mainAxisSize: MainAxisSize.min, // Ajuste la taille au contenu
      children: [
        GestureDetector(
          onTap: busProvider.updateVerification,
          child: Icon(Icons.refresh, color: Colors.blue, size: 24), // Icône cliquable
        ),
        SizedBox(width: 8), // Espacement entre icône et texte
        Text(
          "Verification de mis à jour des donnees",
          style: TextStyle(fontSize: 14, color: Colors.black54),
        ),
      ],
    );
  }



}
