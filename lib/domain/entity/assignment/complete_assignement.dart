class CompleteAssignment {
  String assignmentDate;
  String licensePlate;
  String model;
  int status;
  String driverLastName;
  String driverFirstName;
  String coDriverLastName;
  String coDriverFirstName;
  int isDefault;

  int horsepower;
  double fuelConsumptionL100Km;
  int weightKg;
  int widthMm;
  int heightMm;
  int launchYear;
  int lengthMm;

  CompleteAssignment({
    required this.assignmentDate,
    required this.licensePlate,
    required this.model,
    required this.status,
    required this.driverLastName,
    required this.driverFirstName,
    required this.coDriverLastName,
    required this.coDriverFirstName,
    required this.isDefault,
    required this.horsepower,
    required this.fuelConsumptionL100Km,
    required this.weightKg,
    required this.widthMm,
    required this.heightMm,
    required this.launchYear,
    required this.lengthMm,
  });
}
