import 'package:intl/intl.dart';

class PriceFormat {

  static  formatAR(int? montant, {String locale = 'fr_FR'}) {
    montant ??= 0;
    final format = NumberFormat.currency(
      locale: locale,
      symbol: 'AR', // ou '€', 'F CFA', 'MAD', etc.
      decimalDigits: 0, // tu peux mettre 2 si tu veux les centimes
    );
    return format.format(montant).trim();
  }
  
}

