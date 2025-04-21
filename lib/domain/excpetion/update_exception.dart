class UpdateException implements Exception {
  final String message;
  UpdateException([this.message = "Une mise à jour est necessaire pour poursuivre cette action"]);

  @override
  String toString() => "UpdateException: $message";
}
