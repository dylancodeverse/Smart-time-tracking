import 'package:sola/data/interface/datasource/datasource.dart';
import 'package:sola/domain/entity/bus_state.dart';
import 'package:sola/domain/service/interface/i_prediction_duration.dart';

class PredictionDuration implements IPredictionDuration {

  DataSource<BusState> busState ;

  PredictionDuration({required this.busState});

  @override
  int getArrivalPrediction(int departure) {
    return departure + (45 * 60); // Ajoute 18 minutes en secondes
  }
  
  @override
   Future<int> getDepartureEstimation() async{
    // getLastBus on queue
    List<BusState> busStateList = await busState.getAll();
    return (busStateList[0].nextChangeDatePrevision as int)+ (3*60) ;
  }
}
