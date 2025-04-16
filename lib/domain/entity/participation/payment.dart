class PaymentParticipation {
  int? id;
  int? montantTotal;
  int participationDate;
  String? reference;

  PaymentParticipation({
    this.id,
    this.montantTotal = 0,
    required this.participationDate,
    this.reference,
  });


}
