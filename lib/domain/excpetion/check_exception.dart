class CadenceException {
  final String message;

  CadenceException([this.message="Doit respecter la cadence"]);

  @override
  String toString() => "CandenceException: $message";  
}

class IndispoException {
  String message;
  IndispoException([this.message="Le chauffeur n'est disponible qu'avant le "]);
    @override
  String toString() => "IndispoException: $message";  
}