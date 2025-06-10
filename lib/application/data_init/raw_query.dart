class RawQuery {
  static String nondispo = '''
  SELECT id, id_chauffeur ,  datedebut, datefin from NONDISPOCHAUFFEUR
  where id_chauffeur= '%' and
  datedebut <=  strftime('%s', 'now', 'localtime') * 1000 
  and
  datefin >= strftime('%s', 'now', 'localtime') * 1000
  UNION
  SELECT 
    0 as id,
    c.id_chauffeur AS id_chauffeur,
    0 as datedebut,
     0 as datefin
    FROM affectations c
    JOIN etat_voitures_actu eva ON eva.id_affectation = c.id
    WHERE eva.etat_pointage = 10
    and c.id_chauffeur = '%'
    ;
''';
}