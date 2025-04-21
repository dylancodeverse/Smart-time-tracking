class Participation {
  int? id;
  String? busId;
  int? participationDate;
  int? amount;
  String? comments;
  int? superParticipation ;
  Participation({
    this.id,
    required this.busId,
    required this.participationDate,
    required this.amount,
    required this.superParticipation,
    this.comments
  });


}
