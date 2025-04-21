class CommentsException implements Exception {
  final String message;

  CommentsException([this.message = "Raison obligatoire"]);

  @override
  String toString() => "CommentsException: $message";

}