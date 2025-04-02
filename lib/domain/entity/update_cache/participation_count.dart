class ParticipationCount {
  int participationCount;
  DateTime dateTime;
  ParticipationCount({required this.participationCount, required this.dateTime});

  Map<String, dynamic> toJson() => {
      'dateTime': dateTime.toIso8601String().split('T')[0],
      'participationCount': participationCount
    };

  static ParticipationCount fromJson(Map<String, dynamic> json) {
    return ParticipationCount(
      dateTime: DateTime.parse(json['dateTime']),
      participationCount: json['participationCount']
    );
  }
}