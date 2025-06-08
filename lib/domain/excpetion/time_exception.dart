class TimeException {
  final String message;

  TimeException([this.message="Modification interdite en dehors des heures autorisées."]);

  @override
  String toString() => "TimeException: $message";  
}