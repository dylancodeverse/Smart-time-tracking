import 'package:sola/domain/entity/depense/depense.dart';

class DepenseHelper {
  static Depense fromMap(Map<String, dynamic> map) {
    Depense dep = Depense(
      amount: map['montant'],
      reason: map['motif'],
    );
    if (map['id']!=null) {
      dep.id= map['id'];
    }
    try{
      dep.date = map['datej'];
    }
    // ignore: empty_catches
    catch(e){}
    return dep;
  }

  static Map<String, dynamic> toMap(Depense depense) {
    final map = <String, dynamic>{
      'montant': depense.amount,
      'datej': depense.date,
      'motif': depense.reason,
    };

    if (depense.id != null) {
      map['id'] = depense.id;
    }

    return map;
  }
}
