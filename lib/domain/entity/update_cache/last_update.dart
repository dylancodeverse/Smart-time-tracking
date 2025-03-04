class LastUpdate {
  final DateTime date;

  LastUpdate({required this.date});

  Map<String, dynamic> toJson() => {
        'date': date.toIso8601String().split('T')[0],
      };

  static LastUpdate fromJson(Map<String, dynamic> json) {
    return LastUpdate(
      date: DateTime.parse(json['date']),
    );
  }
}
