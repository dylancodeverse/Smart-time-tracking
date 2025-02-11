class SqlRequestConfig{
  static String sqlRequestReport ='''
  with initialisation as 
    (select id as id_affectation, 0 as nombre_tours , 0 as total_montant , % as date_jour from affectations),
    init_pointage as
    (select * from initialisation union select * from details_pointage_jour),
    details_pointage as
    (select id_affectation , sum(nombre_tours) as nombre_tours ,sum(total_montant) as total_montant from init_pointage group by id_affectation)

    select nombre_tours, total_montant , affectations_completes.* from affectations_completes join details_pointage on details_pointage.id_affectation = 
    affectations_completes.affectation_id ;

   ''';  


  static getTodayReportRequest(){
    return sqlRequestReport.replaceAll("%","strftime('%Y-%m-%d', 'now')" ) ;
  }  
}