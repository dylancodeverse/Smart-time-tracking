INSERT OR IGNORE INTO vehicules (id, immatriculation, modele, statut)
SELECT
    lower(hex(randomblob(16))) AS id,
    immatriculation,
    modele,
    statut
FROM import_affectations_completes;


INSERT OR IGNORE INTO chauffeurs (id, nom, prenom)
SELECT
    lower(hex(randomblob(16))) AS id,
    chauffeur_nom,
    chauffeur_prenom
FROM import_affectations_completes;

INSERT OR IGNORE INTO copilote (id, nom, prenom)
SELECT
    lower(hex(randomblob(16))) AS id,
    copilote_nom,
    copilote_prenom
FROM import_affectations_completes;


INSERT OR IGNORE INTO affectations (id_vehicule, id_chauffeur, id_copilote, is_default, affectation_date)
SELECT
    v.id,
    c.id,
    cp.id,
    iac.is_default,
    iac.affectation_date
FROM import_affectations_completes iac
JOIN vehicules v ON v.immatriculation = iac.immatriculation
JOIN chauffeurs c ON c.nom = iac.chauffeur_nom AND c.prenom = iac.chauffeur_prenom
JOIN copilote cp ON cp.nom = iac.copilote_nom AND cp.prenom = iac.copilote_prenom;

INSERT OR IGNORE INTO etat_voitures_actu (etat_pointage, id_vehicule, id_affectation, participation_etat)
SELECT 
  0 AS etat_pointage,
  a.id_vehicule,
  a.id AS id_affectation,
  0 AS participation_etat
FROM affectations a
WHERE a.is_default = 1;


insert or IGNORE into violation (lib)
select lib  from import_violation ; 

