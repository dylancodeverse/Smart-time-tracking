import 'package:intl/intl.dart';
import 'package:sola/domain/excpetion/price_exception.dart';

class PriceFormat {

  static  formatAR(num? montant, {String locale = 'fr_FR'}) {
    montant ??= 0;
    var formatter = NumberFormat('#,##0');
    // Formater le nombre
    String formattedNumber = formatter.format(montant);
    return "$formattedNumber AR";
  }

  static int getPrice(String price, num minim, num max) {
    int price2;
    try {
      price2= int.parse(price);
    } catch (e) {
      throw PrixDoitEtreNombreException(price);
    }
    if (price2 <minim) {
      throw PrixMinimum(price2, minim);
    }
    if(price2>max){
      throw PrixMaximum(price2, max);
    }
    if(price2%100 !=0){
      throw PrixMultipleDe100Exception(price2);
    }
    return price2;
  }
  
}

