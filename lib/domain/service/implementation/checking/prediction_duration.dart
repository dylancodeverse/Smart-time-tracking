import 'package:sola/data/interface/datasource/datasource.dart';
import 'package:sola/domain/entity/bus_state.dart';
import 'package:sola/domain/service/interface/checking/i_prediction_duration.dart';
import 'package:sola/lib/date_helper.dart';

class PredictionDuration implements IPredictionDuration {

  DataSource<BusState> busState ;

  PredictionDuration({required this.busState});

  @override
  int getArrivalPrediction(int departure) {
    return departure + (45 * 60 *1000); 
  }
  
  @override
   Future<int> getDepartureEstimation() async{
    // getLastBus on queue
    List<BusState> busStateList = await busState.getAll();
    try{
      return (busStateList[0].nextChangeDatePrevision as int)+ (3*60 *1000) ;
    }catch(e){
      return Date.getTimestampNow() + 3*60 *1000; 
    }
  }
}
