class StatsPointage {
  final int tourCount;
  final int totalAmount;
  final int pointageStatus;
  final int? lastPointage;
  final String registrationNumber;
  final String model;
  final int status;
  final String vehicleId;
  final String assignmentId;
  final int assignmentDate;
  final String driverId;
  final String driverFirstName;
  final String driverLastName;
  final String coDriverId;
  final String coDriverFirstName;
  final String coDriverLastName;

  StatsPointage({
    required this.tourCount,
    required this.totalAmount,
    required this.pointageStatus,
    this.lastPointage,
    required this.registrationNumber,
    required this.model,
    required this.status,
    required this.vehicleId,
    required this.assignmentId,
    required this.assignmentDate,
    required this.driverId,
    required this.driverFirstName,
    required this.driverLastName,
    required this.coDriverId,
    required this.coDriverFirstName,
    required this.coDriverLastName,
  });

  /// 🔄 Converts a Map into a `StatsPointage` object
  factory StatsPointage.fromMap(Map<String, dynamic> map) {
    return StatsPointage(
      tourCount: map['nombre_tours'] as int,
      totalAmount: map['total_montant'] as int,
      pointageStatus: map['etat_pointage'] as int,
      lastPointage: map['dernier_pointage'] as int?,
      registrationNumber: map['immatriculation'] as String,
      model: map['modele'] as String,
      status: map['statut'] as int,
      vehicleId: map['vehicule_id'] as String,
      assignmentId: map['affectation_id'] as String,
      assignmentDate: map['affectation_date'] as int,
      driverId: map['chauffeur_id'] as String,
      driverFirstName: map['chauffeur_nom'] as String,
      driverLastName: map['chauffeur_prenom'] as String,
      coDriverId: map['copilote_id'] as String,
      coDriverFirstName: map['copilote_nom'] as String,
      coDriverLastName: map['copilote_prenom'] as String,
    );
  }

  /// 🔄 Converts a `StatsPointage` object into a Map
  Map<String, dynamic> toMap() {
    return {
      'tour_count': tourCount,
      'total_amount': totalAmount,
      'pointage_status': pointageStatus,
      'last_pointage': lastPointage,
      'registration_number': registrationNumber,
      'model': model,
      'status': status,
      'vehicle_id': vehicleId,
      'assignment_id': assignmentId,
      'assignment_date': assignmentDate,
      'driver_id': driverId,
      'driver_first_name': driverFirstName,
      'driver_last_name': driverLastName,
      'co_driver_id': coDriverId,
      'co_driver_first_name': coDriverFirstName,
      'co_driver_last_name': coDriverLastName,
    };
  }
}
