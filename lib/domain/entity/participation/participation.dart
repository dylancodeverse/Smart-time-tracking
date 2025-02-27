class Participation {
  int? id;
  String busId;
  int participationDate;
  int amount;
  String? comments;
  Participation({
    this.id,
    required this.busId,
    required this.participationDate,
    required this.amount,
    this.comments
  });


}
