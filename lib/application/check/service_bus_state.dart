import 'package:sola/domain/entity/assignement.dart';
import 'package:sola/domain/entity/bus.dart';
import 'package:sola/domain/entity/check.dart';
import 'package:sola/domain/entity/copilot.dart';
import 'package:sola/domain/entity/driver.dart';
import 'package:sola/domain/entity/bus_state.dart';

class ServiceBusState {
  /// Convertit un objet `BusState` en `Map<String, dynamic>` pour l'insertion en base de données.
  static Map<String, dynamic> toMap(BusState busState) {
    return {
      "id": busState.id,
      "etat_pointage": busState.statusCheck,
      "id_vehicule": busState.lastAssignment.bus?.id,
      "dernier_pointage": busState.lastCheck?.id,
      "id_affectation": busState.lastAssignment.id,
      "estimation_prochaine_action": busState.nextChangeDatePrevision,
    };
  }

  /// Convertit une `Map<String, dynamic>` issue de la base de données en un objet `BusState`.
  static BusState fromMap(Map<String, dynamic> map) {
    return BusState(
      id: map["id"] as int,
      statusCheck: map["etat_pointage"] as int,
      nextChangeDatePrevision: map['estimation_prochaine_action'],
      lastAssignment: Assignment(
        id: map["id_affectation"] as String?,
        assignmentDate: map["affectation_date"] != null
            ? DateTime.parse(map["affectation_date"])
            : null,
        bus: Bus(
          id: map["id_vehicule"] as String?,
          registrationNumber: map["immatriculation"] as String?,
          model: map["modele"] as String?,
          status: map["statut"] as int?,
        ),
        driver: Driver(
          id: map["chauffeur_id"] as String,
          lastName: map["chauffeur_nom"] as String? ?? "Nom inconnu",
          firstName: map["chauffeur_prenom"] as String? ?? "Prénom inconnu",
        ),
        copilot: Copilot(
          id: map["copilote_id"] as String,
          lastName: map["copilote_nom"] as String? ?? "Nom inconnu",
          firstName: map["copilote_prenom"] as String? ?? "Prénom inconnu",
        ),
      ),
      lastCheck: map["dernier_pointage"] != null
          ? Check(
              id: map["dernier_pointage"] as int?,
              arrivalDate: map["date_arrivee"] as int,
              assignment: Assignment(
                id: map["id_affectation"] as String?,
              ),
            )
          : null,
    );
  }

  static BusState fromMapPredictionModel(Map<String, dynamic> map){
    return BusState(id: map['id'],nextChangeDatePrevision: map['estimation_prochaine_action'],statusCheck: map['etat_pointage'],
    lastAssignment: Assignment(id: map['id_affectation']));

  }
}
