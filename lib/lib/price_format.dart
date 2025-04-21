import 'package:intl/intl.dart';

class PriceFormat {

  static  formatAR(int? montant, {String locale = 'fr_FR'}) {
    montant ??= 0;
    var formatter = NumberFormat('#,##0');
    // Formater le nombre
    String formattedNumber = formatter.format(montant);
    return "$formattedNumber AR";
  }
  
}

