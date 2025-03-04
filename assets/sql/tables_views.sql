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
    etat_pointage int, -- 0 depart 1 arrivee
    id_vehicule TEXT,
    dernier_pointage int, -- prochain pointage a mettre a jour
    estimation_prochaine_action int , -- calculer a partir les donnees (si depart + duree moyenne)
                                      -- si arrivee + 3mn estimation_prochaine_action 
    id_affectation text,
    participation_etat int,
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
