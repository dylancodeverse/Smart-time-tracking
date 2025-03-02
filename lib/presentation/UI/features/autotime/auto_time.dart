import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class AutoTimeRequiredScreen extends StatelessWidget {
  const AutoTimeRequiredScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.access_time, 
                size: 80, 
                color: Colors.redAccent
              ),
              SizedBox(height: 20),
              Text(
                "⚠️ L'heure automatique est désactivée !",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20, 
                  fontWeight: FontWeight.bold, 
                  color: Colors.red
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Veuillez activer l'heure automatique dans les paramètres pour continuer.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  // Ouvrir les paramètres de l'heure automatique
                  try {
                    const platform = MethodChannel('com.example.sola/settings');
                    await platform.invokeMethod('openAutoTimeSettings');
                    // Attendre 4 secondes pour vérifier si l'heure automatique a été activée
                    await Future.delayed(Duration(seconds: 4));

                    // Vérifier si l'heure automatique est activée
                    final bool isAutoTimeEnabled = await platform.invokeMethod('isAutoTimeEnabled');

                    // Si l'heure automatique est activée, rediriger vers HomeScreen
                    if (isAutoTimeEnabled ) {
                      if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        } else {
                          // Gérer le cas où il n'y a pas d'écran précédent
                          Navigator.pushNamed(context,'/');
                        }
                    } else {
                      // Si non, informer l'utilisateur et rester sur cet écran
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("L'heure automatique n'est pas activée. Veuillez réessayer.")),
                      );
                    }
                  // ignore: empty_catches
                  } on PlatformException {
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent, // Bouton rouge
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text("Ouvrir les paramètres", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
