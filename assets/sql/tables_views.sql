    CREATE TABLE vehicules (
      id TEXT PRIMARY KEY,
      immatriculation TEXT NOT NULL UNIQUE,
      modele TEXT NOT NULL,
      statut int NOT NULL
    );

    CREATE TABLE chauffeurs (
        id TEXT PRIMARY KEY,
        nom TEXT NOT NULL,
        prenom TEXT NOT NULL,
        UNIQUE(nom, prenom)
    );

    CREATE TABLE copilote (
      id TEXT PRIMARY KEY,
      nom TEXT NOT NULL,
      prenom TEXT NOT NULL,
      UNIQUE(nom, prenom)
    );

      
    CREATE TABLE affectations (
      id integer PRIMARY KEY AUTOINCREMENT ,
      affectation_date int DEFAULT (strftime('%s', 'now')),
      id_vehicule TEXT NOT NULL,
      id_chauffeur TEXT NOT NULL,
      id_copilote TEXT,
      is_default int ,
      FOREIGN KEY (id_vehicule) REFERENCES vehicules(id),
      FOREIGN KEY (id_chauffeur) REFERENCES chauffeurs(id),
      FOREIGN KEY (id_copilote) REFERENCES chauffeurs(id)
    );



    CREATE TABLE pointages (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      date_arrivee int ,
      date_depart int ,
      id_vehicule text,
      id_affectation TEXT NOT NULL,
      montant int,
      commentaires TEXT,
      FOREIGN KEY (id_affectation) REFERENCES affectations(id),
      FOREIGN KEY (id_vehicule) REFERENCES vehicules(id)
    );




CREATE TABLE etat_voitures_actu (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    etat_pointage int, 
    id_vehicule TEXT,
    dernier_pointage int, -- prochain pointage a mettre a jour
    estimation_prochaine_action int , -- calculer a partir les donnees (si depart + duree moyenne)
                                      -- si arrivee + 3mn estimation_prochaine_action 
    id_affectation text,
    participation_etat int, -- ceci ne gere pas seulement si la voiture a deja paye la participation (OUI OU NON)
                            -- mais aussi si la voiture doit payer la participation (du coup c'est mieux d avoir cette colomne
                            -- que de devoir calculer l etat a chaque fois (1: verification table participation, 2: compter le nombre 
                            -- de pointage du jour))
    FOREIGN KEY (id_affectation) REFERENCES affectations(id),
    FOREIGN KEY (id_vehicule) REFERENCES vehicules(id),
    FOREIGN KEY (dernier_pointage) REFERENCES pointages(id)
);


CREATE VIEW affectations_completes AS
    SELECT 
        a.id AS affectation_id,
        a.affectation_date,
        v.id AS vehicule_id,
        v.immatriculation,
        v.modele,
        v.statut,
        c.id AS chauffeur_id,
        c.nom AS chauffeur_nom,
        c.prenom AS chauffeur_prenom,
        co.id AS copilote_id,
        co.nom AS copilote_nom,
        co.prenom AS copilote_prenom
    FROM affectations a
    JOIN vehicules v ON a.id_vehicule = v.id
    JOIN chauffeurs c ON a.id_chauffeur = c.id
    JOIN copilote co ON a.id_copilote = co.id ;
    
CREATE INDEX IF NOT EXISTS date_arrivee_idx ON pointages(date_arrivee);

CREATE INDEX IF NOT EXISTS date_depart_idx on pointages(date_depart);



CREATE VIEW details_pointage_jour AS
SELECT
    id_vehicule,
    strftime('%Y-%m-%d', datetime(date_arrivee/1000, 'unixepoch')) AS date_jour,
    COUNT(*) AS nombre_tours,
    SUM(montant) AS total_montant
FROM
    pointages
WHERE
    strftime('%Y-%m-%d', datetime(date_arrivee/1000, 'unixepoch')) = strftime('%Y-%m-%d', 'now')
GROUP BY
    date_jour, id_vehicule
ORDER BY
    date_jour;


CREATE VIEW v_etat_voitures_actu AS 
WITH arrivee AS (
    SELECT * FROM etat_voitures_actu WHERE etat_pointage = 20
),
maxdate AS (
    SELECT MAX(estimation_prochaine_action) AS estimation_prochaine_action FROM arrivee
)
SELECT arrivee.* 
FROM arrivee 
WHERE arrivee.estimation_prochaine_action = (SELECT estimation_prochaine_action FROM maxdate);


CREATE TABLE violation (
    id integer PRIMARY KEY AUTOINCREMENT,
    lib char(50) not NULL UNIQUE
);

CREATE TABLE violationparpointage(
    id integer PRIMARY KEY AUTOINCREMENT,
    id_violation integer,
    id_pointage integer ,
    FOREIGN KEY (id_violation) REFERENCES violation(id),
    FOREIGN KEY (id_pointage) REFERENCES pointages(id)
);

CREATE TABLE PARTICIPATION (
    ID INTEGER PRIMARY KEY,
    id_vehicule TEXT ,
    PARTICIPATION_date int not NULL,
    montant int not null,
    comments text
);



create view statistiquejournalier AS

      WITH initialisation AS (
        SELECT id AS id_vehicule, 0 AS nombre_tours, 0 AS total_montant, strftime('%Y-%m-%d', 'now') AS date_jour
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
      order by estimation_prochaine_action asc ;


CREATE VIEW statistiquejournalierParticipationNonPayee
as select * from statistiquejournalier WHERE     
participation_etat = 10;

CREATE VIEW statistiquejournalierParticipationOK
as select * from statistiquejournalier WHERE     
participation_etat = 20;

CREATE VIEW statistiquejournalierParticipationPasDeParticipation
as select * from statistiquejournalier WHERE     
participation_etat = 0;

CREATE view statistiquejournalierVoitureSurRoute
as select * from statistiquejournalier where 
etat_pointage = 10 ;

create view statistiquejournalierVoitureSurTerminus 
as select * from statistiquejournalier where
etat_pointage!= 10 ;

CREATE VIEW statistiquejournalierencadence as 
select * from statistiquejournalierVoitureSurTerminus where estimation_prochaine_action is not null  ;