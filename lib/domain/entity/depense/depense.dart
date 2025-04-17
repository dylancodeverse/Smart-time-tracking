class Depense {
  int? id;
  int amount;
  int? date; // timestamp (datej)
  String? reason;

  Depense({
    this.id,
    required this.amount,
    this.date,
    this.reason,
  });

  Depense copyWith({
    int? id,
    int? amount,
    int? date,
    String? reason,
  }) {
    return Depense(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      reason: reason ?? this.reason,
    );
  }
}
