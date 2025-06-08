import 'package:sola/lib/price_format.dart';

class PrixException implements Exception {
  final String message;
  PrixException(this.message);

  @override
  String toString() => 'PrixException: $message';
}

class PrixDoitEtreNombreException extends PrixException {
  PrixDoitEtreNombreException(String input)
      : super('Le prix doit être un nombre. Valeur actuelle: $input');
}

class PrixMultipleDe100Exception extends PrixException {
  PrixMultipleDe100Exception(num value)
      : super('Le prix doit être un multiple de 100. Valeur actuelle: ${PriceFormat.formatAR(value)}');
}

class PrixMinimum extends PrixException{
  PrixMinimum(num value, num minim): super("Le prix doit être superieur à ${PriceFormat.formatAR(minim)}. Valeur actuelle: ${PriceFormat.formatAR(value)}");
}
class PrixMaximum extends PrixException{
  PrixMaximum(num value, num minim): super("Le prix doit être inférieur à ${PriceFormat.formatAR(minim)}. Valeur actuelle: ${PriceFormat.formatAR(value)}");
}
