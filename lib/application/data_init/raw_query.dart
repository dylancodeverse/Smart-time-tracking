class RawQuery {
  static String nondispo = '''
  SELECT * from NONDISPOCHAUFFEUR
  where id_chauffeur= '%' and
  datedebut <=  strftime('%s', 'now', 'localtime') * 1000 
  and
  datefin >= strftime('%s', 'now', 'localtime') * 1000;
''';
}