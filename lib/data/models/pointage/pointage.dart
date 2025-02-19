class Pointages {
  int? id;
  int? dateArrivee;
  int? dateDepart;
  String? idAffectation;
  String idVehicule;
  int ? montant;
  String ? commentaires;

  Pointages({required this.dateArrivee, this.dateDepart,required this.idAffectation, this.montant, this.commentaires,required this.idVehicule});

  Pointages.depart(this.idAffectation, this.dateDepart,  this.idVehicule); 

  Pointages.arrivee({required this.idVehicule, required this.montant, this.commentaires, required this.dateArrivee, required this.id});

  factory Pointages.fromMap(Map<String,dynamic> map){
    return Pointages(
      dateArrivee:map['date_arrivee'], 
      dateDepart:map['date_depart'], 
      idAffectation:map['id_affectation'], 
      montant:map['montant'], 
      commentaires:map['commentaires'],
      idVehicule: map['id_vehicule']
    );
  }
   Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date_arrivee': dateArrivee,
      'date_depart': dateDepart,
      'id_affectation': idAffectation,
      'montant': montant,
      'commentaires': commentaires,
      'id_vehicule': idVehicule
    };
  }
  Map<String, dynamic> mapTerminerTour(){
    return {
      'id': id,
      'date_arrivee': dateArrivee,
      'montant': montant,
      'id_vehicule': idVehicule
    };
  }

}