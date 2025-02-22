import 'package:sola/domain/entity/assignement.dart';

class Check {
  int? id; // Peut être null avant insertion en base
  Assignment assignment;
  int arrivalDate;
  int? departureDate;
  int ? amount;
  String ? comments;


  Check({this.id, required this.assignment, required this.arrivalDate});

}