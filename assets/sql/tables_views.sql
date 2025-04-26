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
      affectation_date int ,
      id_vehicule TEXT NOT NULL,
      id_chauffeur TEXT NOT NULL,
      id_copilote TEXT,
      is_default int ,
      FOREIGN KEY (id_vehicule) REFERENCES vehicules(id),
      FOREIGN KEY (id_chauffeur) REFERENCES chauffeurs(id),
      FOREIGN KEY (id_copilote) REFERENCES chauffeurs(id),
      UNIQUE (id_vehicule, id_chauffeur, id_copilote, affectation_date)

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
      FOREIGN KEY (id_vehicule) REFERENCES vehicules(id),
      UNIQUE (id_vehicule, date_arrivee, date_depart)
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
    FOREIGN KEY (dernier_pointage) REFERENCES pointages(id),
    UNIQUE(id_vehicule)
);


CREATE VIEW affectations_completes AS
    SELECT 
        a.id AS affectation_id,
        a.affectation_date,
        a.is_default,
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
      order by estimation_prochaine_action is null, estimation_prochaine_action asc ;


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


CREATE TABLE PAYMENTPARTICIPATION(
  id integer PRIMARY KEY AUTOINCREMENT,
  PARTICIPATION_date int not NULL,
  reference text unique
);

-- details participation
CREATE TABLE PARTICIPATION (
    ID INTEGER PRIMARY KEY AUTOINCREMENT,
    id_vehicule TEXT ,
    PARTICIPATION_date int not NULL,
    montant int not null,
    comments text,
    id_PAYMENTPARTICIPATION int ,
    FOREIGN KEY (id_PAYMENTPARTICIPATION) REFERENCES PAYMENTPARTICIPATION(id),
    unique(id_vehicule,id_PAYMENTPARTICIPATION)
);

CREATE TABLE MOTIFDEPENSE(
  id integer PRIMARY KEY AUTOINCREMENT,
  montant integer ,
  datej integer not null,
  motif text
);

create view motifdepense_du_jour as 
select * from MOTIFDEPENSE 
where strftime('%Y-%m-%d', datej / 1000, 'unixepoch') = strftime('%Y-%m-%d', 'now');




CREATE  VIEW depense_par_jour as
SELECT 
  strftime('%Y-%m-%d', datej / 1000, 'unixepoch') AS datej,
  SUM(montant) AS montant
FROM 
  MOTIFDEPENSE

GROUP BY 
  strftime('%Y-%m-%d', datej / 1000, 'unixepoch');



CREATE VIEW DEPENSE_DU_JOUR_DEFAUT AS
SELECT strftime('%Y-%m-%d', 'now') AS datej, 0 AS montant;



CREATE VIEW depense_du_jour_temp AS
SELECT * FROM depense_par_jour 
WHERE datej = strftime('%Y-%m-%d', 'now')
UNION 
SELECT * FROM DEPENSE_DU_JOUR_DEFAUT;


CREATE VIEW depense_du_jour AS 
SELECT datej, SUM(montant) AS montant 
FROM depense_du_jour_temp 
GROUP BY datej;




CREATE VIEW participation_par_jour AS
SELECT 
  strftime('%Y-%m-%d', PARTICIPATION_date / 1000, 'unixepoch') AS PARTICIPATION_date,
  SUM(montant) AS montant, count(*) as count
FROM 
  PARTICIPATION
GROUP BY 
  strftime('%Y-%m-%d', PARTICIPATION_date / 1000, 'unixepoch')
ORDER BY 
  PARTICIPATION_date DESC;

create view participation_du_jour_defaut as 
select strftime('%Y-%m-%d', 'now') as  PARTICIPATION_date , 0 as montant , 0 as count;

CREATE VIEW PARTICIPATION_DU_JOUR_TEMP AS 
SELECT * from participation_par_jour 
where PARTICIPATION_date =  strftime('%Y-%m-%d', 'now')
union select * from participation_du_jour_defaut ;


CREATE VIEW participation_du_jour as 
SELECT PARTICIPATION_date , sum(montant) as montant ,sum(count) as count from PARTICIPATION_DU_JOUR_TEMP 
GROUP by  PARTICIPATION_date;


CREATE VIEW statsparticipationavecdepensedujour as 
select participation_date , participation_du_jour.montant as montant_participation
, depense_du_jour.montant as depense , count
from participation_du_jour
join depense_du_jour on participation_du_jour.participation_date = depense_du_jour.datej ;


CREATE VIEW participation_du_jour_liste as
select * from participation where strftime('%Y-%m-%d', PARTICIPATION_date / 1000, 'unixepoch') =   strftime('%Y-%m-%d', 'now') ;

CREATE VIEW participation_du_jour_liste_lib as 
select  vehicules.immatriculation, vehicules.modele, 
participation_du_jour_liste.* 
from vehicules join participation_du_jour_liste 
on participation_du_jour_liste.id_vehicule =vehicules.id ;




CREATE TABLE import_affectations_completes (
    affectation_date TEXT,
    immatriculation TEXT,
    modele TEXT,
    statut INTEGER,
    chauffeur_nom TEXT,
    chauffeur_prenom TEXT,
    copilote_nom TEXT,
    copilote_prenom TEXT,
    is_default int 
);


CREATE TABLE import_violation(
    lib text 
);


CREATE VIEW violations_des_pointages_complets AS
SELECT 
  p.date_arrivee,
  p.date_depart,
  ac.immatriculation,
  ac.chauffeur_nom,
  ac.chauffeur_prenom,
  ac.copilote_nom,
  ac.copilote_prenom,
  p.montant,
  p.commentaires,
  v.lib AS violation_libelle
FROM pointages p
JOIN affectations_completes ac ON p.id_affectation = ac.affectation_id
LEFT JOIN violationparpointage vp ON p.id = vp.id_pointage
LEFT JOIN violation v ON vp.id_violation = v.id;


CREATE VIEW participation_complete AS
SELECT
  p.PARTICIPATION_date,
  v.immatriculation,
  p.montant,
  p.comments,
  pay.reference AS reference_paiement,
  pay.PARTICIPATION_date AS date_paiement
FROM PARTICIPATION p
JOIN PAYMENTPARTICIPATION pay ON p.id_PAYMENTPARTICIPATION = pay.id
JOIN vehicules v ON p.id_vehicule = v.id;
