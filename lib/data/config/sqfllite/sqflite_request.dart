// ignore_for_file: prefer_final_fields

class SqlfliteRequest {
    static String _statsRequest ='''
      WITH initialisation AS (
        SELECT id AS id_vehicule, 0 AS nombre_tours, 0 AS total_montant, % AS date_jour
        FROM vehicules
      ),
      init_pointage AS (
        SELECT * FROM initialisation
        UNION ALL
        SELECT details_pointage_jour.id_vehicule, details_pointage_jour.nombre_tours, 
              details_pointage_jour.total_montant, details_pointage_jour.date_jour
        FROM details_pointage_jour
      ),
      details_pointage AS (
        SELECT id_vehicule, SUM(nombre_tours) AS nombre_tours, SUM(total_montant) AS total_montant
        FROM init_pointage
        GROUP BY id_vehicule
      ),
      details_pointage_etat AS (
        SELECT dp.id_vehicule, dp.nombre_tours, dp.total_montant, eva.id as etat_pointage_id 
              ,eva.etat_pointage, eva.id_affectation , eva.dernier_pointage , eva.estimation_prochaine_action
              , eva.participation_etat
        FROM etat_voitures_actu eva
        JOIN details_pointage dp ON eva.id_vehicule = dp.id_vehicule
      )
      SELECT 
        participation_etat,
        nombre_tours,
        total_montant, 
        etat_pointage, 
        etat_pointage_id,     
        dernier_pointage,
        estimation_prochaine_action,
        vehicules.immatriculation,
        vehicules.modele,
        vehicules.statut,
        vehicules.id as vehicule_id,
        a.id as affectation_id,
        a.affectation_date,
        c.id AS chauffeur_id,
        c.nom AS chauffeur_nom,
        c.prenom AS chauffeur_prenom,
        co.id AS copilote_id,
        co.nom AS copilote_nom,
        co.prenom AS copilote_prenom
      FROM vehicules 
      JOIN details_pointage_etat dpe ON dpe.id_vehicule = vehicules.id 
      JOIN affectations a ON dpe.id_affectation = a.id
      JOIN chauffeurs c ON a.id_chauffeur = c.id
      JOIN copilote co ON a.id_copilote = co.id
      order by estimation_prochaine_action is null, estimation_prochaine_action asc
   ''';  

  static getTodayStats(){
    return _statsRequest.replaceAll("%","strftime('%Y-%m-%d', 'now')" ) ;
  }  

  static String _completeAssignement = '''
    SELECT * FROM AFFECTATIONS_COMPLETES
    WHERE vehicule_id = '%'
  ''';

  static String getCompleteASsignementByBusId(String busId){
    return _completeAssignement.replaceAll("%", busId);
  }

  // requete speciale ho anle BusStats ankoatra anle mahazatra (mi override anle requete mapped aminy) 
  static String getBusInQueueASC(){
    return ''' SELECT * from statistiquejournalierencadence ''';
  }

}