class CompleteViolation {
  int? arrivalDate;
  int? departureDate;
  String? registration;
  String? driverLastName;
  String? driverFirstName;
  String? coDriverLastName;
  String? coDriverFirstName;
  double? amount;
  String? comments;
  String? violationLabel;

  CompleteViolation({
    required this.arrivalDate,
    required this.departureDate,
    required this.registration,
    required this.driverLastName,
    required this.driverFirstName,
    required this.coDriverLastName,
    required this.coDriverFirstName,
    required this.amount,
    required this.comments,
    required this.violationLabel,
  });
}
