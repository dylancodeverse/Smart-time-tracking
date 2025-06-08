// Exception de base pour les erreurs de référence
class ReferenceException implements Exception {
  final String message;
  ReferenceException(this.message);

  @override
  String toString() => 'ReferenceException: $message';
}

// La référence doit être un nombre
class ReferenceDoitEtreNombreException extends ReferenceException {
  ReferenceDoitEtreNombreException(String input)
      : super('La référence doit être un nombre. Valeur actuelle: $input');
}

class ReferenceDoitEtreNombrePositifException extends ReferenceException {
  ReferenceDoitEtreNombrePositifException(String input)
      : super('La référence doit être un nombre positif. Valeur actuelle: $input');
}

// La référence doit avoir exactement 10 caractères
class ReferenceLongueurInvalideException extends ReferenceException {
  ReferenceLongueurInvalideException(String input)
      : super('La référence doit contenir exactement 10 caractères. Valeur actuelle: ${input.length}');
}
