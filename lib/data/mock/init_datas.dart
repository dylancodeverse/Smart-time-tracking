import 'package:sqflite/sqflite.dart';

class InitDatas {
  Future<void> insertInitialData(Database db) async {
    
    List<Map<String, dynamic>> vehicules = [
      {"id": "1", "immatriculation": "AA-123-AA", "modele": "Renault Kangoo", "statut": 1},
      {"id": "2", "immatriculation": "BB-456-BB", "modele": "Peugeot Partner", "statut": 1},
      {"id": "3", "immatriculation": "CC-789-CC", "modele": "Citroën Berlingo", "statut": 1},
      {"id": "4", "immatriculation": "DD-101-DD", "modele": "Ford Transit", "statut": 1},
      {"id": "5", "immatriculation": "EE-202-EE", "modele": "Volkswagen Transporter", "statut": 1},
      {"id": "6", "immatriculation": "FF-303-FF", "modele": "Mercedes Sprinter", "statut": 1},
      {"id": "7", "immatriculation": "GG-404-GG", "modele": "Opel Vivaro", "statut": 1},
      {"id": "8", "immatriculation": "HH-505-HH", "modele": "Toyota ProAce", "statut": 1},
      {"id": "9", "immatriculation": "II-606-II", "modele": "Nissan NV300", "statut": 1},
      {"id": "10", "immatriculation": "JJ-707-JJ", "modele": "Fiat Doblo", "statut": 1},
      {"id": "11", "immatriculation": "KK-808-KK", "modele": "Iveco Daily", "statut": 1},
      {"id": "12", "immatriculation": "LL-909-LL", "modele": "Hyundai H350", "statut": 1},
      {"id": "13", "immatriculation": "MM-010-MM", "modele": "Isuzu D-Max", "statut": 1},
      {"id": "14", "immatriculation": "NN-111-NN", "modele": "Ford Ranger", "statut": 1},
      {"id": "15", "immatriculation": "OO-222-OO", "modele": "Mitsubishi L200", "statut": 1},
      {"id": "16", "immatriculation": "PP-333-PP", "modele": "Chevrolet Silverado", "statut": 1},
      {"id": "17", "immatriculation": "QQ-444-QQ", "modele": "Dacia Dokker", "statut": 1},
      {"id": "18", "immatriculation": "RR-555-RR", "modele": "Mazda BT-50", "statut": 1},
    ];

    for (var vehicule in vehicules) {
      await db.insert("vehicules", vehicule);
    }
    List<Map<String, dynamic>> chauffeurs = [
      {"id": "1", "nom": "Dupont", "prenom": "Jean"},
      {"id": "2", "nom": "Martin", "prenom": "Paul"},
      {"id": "3", "nom": "Bernard", "prenom": "Luc"},
      {"id": "4", "nom": "Petit", "prenom": "François"},
      {"id": "5", "nom": "Robert", "prenom": "Marc"},
      {"id": "6", "nom": "Richard", "prenom": "Julien"},
      {"id": "7", "nom": "Durand", "prenom": "Olivier"},
      {"id": "8", "nom": "Leroy", "prenom": "Pierre"},
      {"id": "9", "nom": "Morel", "prenom": "David"},
      {"id": "10", "nom": "Fournier", "prenom": "Alexandre"},
      {"id": "11", "nom": "Girard", "prenom": "Maxime"},
      {"id": "12", "nom": "André", "prenom": "Nicolas"},
      {"id": "13", "nom": "Lambert", "prenom": "Antoine"},
      {"id": "14", "nom": "Bonnet", "prenom": "Benoît"},
      {"id": "15", "nom": "François", "prenom": "Xavier"},
      {"id": "16", "nom": "Rousseau", "prenom": "Gérard"},
      {"id": "17", "nom": "Blanc", "prenom": "Vincent"},
      {"id": "18", "nom": "Garnier", "prenom": "Sébastien"},
      {"id": "19", "nom": "Chevalier", "prenom": "Thierry"},
      {"id": "20", "nom": "Muller", "prenom": "Jacques"},
      {"id": "21", "nom": "Leclerc", "prenom": "Guillaume"},
      {"id": "22", "nom": "Lemoine", "prenom": "Stéphane"},
    ];

    for (var chauffeur in chauffeurs) {
      await db.insert("chauffeurs", chauffeur);
    }

    List<Map<String, dynamic>> copilotes = [
      {"id": "1", "nom": "Dupuis", "prenom": "Simon"},
      {"id": "2", "nom": "Marchand", "prenom": "Gabriel"},
      {"id": "3", "nom": "Perrot", "prenom": "Romain"},
      {"id": "4", "nom": "Lemoine", "prenom": "Théo"},
      {"id": "5", "nom": "Dumas", "prenom": "Lucas"},
      {"id": "6", "nom": "Rolland", "prenom": "Hugo"},
      {"id": "7", "nom": "Barbier", "prenom": "Jules"},
      {"id": "8", "nom": "Roy", "prenom": "Louis"},
      {"id": "9", "nom": "Gauthier", "prenom": "Mathieu"},
      {"id": "10", "nom": "Leclercq", "prenom": "Nathan"},
      {"id": "11", "nom": "Guillet", "prenom": "Victor"},
      {"id": "12", "nom": "Guichard", "prenom": "Noah"},
      {"id": "13", "nom": "Delorme", "prenom": "Enzo"},
      {"id": "14", "nom": "Chauveau", "prenom": "Arthur"},
      {"id": "15", "nom": "Pires", "prenom": "Ethan"},
      {"id": "16", "nom": "Valentin", "prenom": "Raphaël"},
      {"id": "17", "nom": "Tanguy", "prenom": "Adrien"},
      {"id": "18", "nom": "Aubert", "prenom": "Baptiste"},
      {"id": "19", "nom": "Boucher", "prenom": "Sacha"},
      {"id": "20", "nom": "Lejeune", "prenom": "Clément"},
      {"id": "21", "nom": "Benoit", "prenom": "Florian"},
      {"id": "22", "nom": "Lucas", "prenom": "Tom"},
    ];

    for (var copilote in copilotes) {
      await db.insert("copilote", copilote);
    }

    for (int i = 1; i <= 18; i++) {
      await db.insert("affectations", {
        "id": "$i",
        "affectation_date": "2024-02-${10 + i}",
        "id_vehicule": "$i",
        "id_chauffeur": "$i",
        "id_copilote": "$i",
        "is_default": 1
      });
    }


    for (int i = 19; i <= 22; i++) {
      await db.insert("affectations", {
        "id": "$i",
        "affectation_date": "2024-03-${10 + i}",
        "id_vehicule": "${(i % 18) + 1}",
        "id_chauffeur": "$i",
        "id_copilote": "${(i % 22) + 1}",
        "is_default": 0
      });
    }

    await _insertEtatVoitures(db);

    await _insertViolations(db);
  }
  Future<void> _insertEtatVoitures(Database db) async {
    // Récupérer les affectations par défaut
    List<Map<String, dynamic>> affectations = await db.query(
      "affectations",
      where: "is_default = 1",
    );

    // Insérer dans etat_voitures_actu pour chaque affectation par défaut
    for (var affectation in affectations) {
      String idVehicule = affectation["id_vehicule"];
      String idAffectation = affectation["id"];

      // Insérer l'état du véhicule (pointage départ = 0)
      await db.insert("etat_voitures_actu", {
        "etat_pointage": 0, // pointage départ
        "id_vehicule": idVehicule,
        "id_affectation": idAffectation,
      });
    }
  }



Future<void> _insertViolations(Database db) async {
  List<Map<String, dynamic>> violations = [
    {"id": 1, "lib": "Excès de vitesse"},
    {"id": 2, "lib": "Stationnement interdit"},
    {"id": 3, "lib": "Non-port de ceinture"},
    {"id": 4, "lib": "Téléphone au volant"},
    {"id": 5, "lib": "Franchissement de ligne continue"},
    {"id": 6, "lib": "Non-respect du feu rouge"},
    {"id": 7, "lib": "Non-respect du stop"},
    {"id": 8, "lib": "Conduite en état d'ivresse"},
    {"id": 9, "lib": "Absence de contrôle technique"},
    {"id": 10, "lib": "Défaut d’assurance"},
  ];

  for (var violation in violations) {
    await db.insert(
      "violation",
      violation,
      conflictAlgorithm: ConflictAlgorithm.ignore, // Ignore si la valeur est déjà présente
    );
  }
}

}