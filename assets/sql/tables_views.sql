    CREATE TABLE vehicules (
      id TEXT PRIMARY KEY,
      immatriculation TEXT NOT NULL UNIQUE,
      modele TEXT NOT NULL,
      statut INTEGER NOT NULL
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
      id TEXT PRIMARY KEY,
      affectation_date TEXT NOT NULL,
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
      date_arrivee INTEGER NOT NULL,
      date_depart INTEGER ,
      id_vehicule TEXT NOT NULL,
      id_chauffeur TEXT NOT NULL,
      montant REAL NOT NULL,
      commentaires TEXT,
      FOREIGN KEY (id_vehicule) REFERENCES vehicules(id),
      FOREIGN KEY (id_chauffeur) REFERENCES chauffeurs(id)
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
        JOIN copilote co ON a.id_copilote = co.id
        WHERE a.is_default = 1;
    
