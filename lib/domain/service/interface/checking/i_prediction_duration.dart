abstract class IPredictionDuration {
  int getArrivalPrediction(int departure,List<double> features);
  Future<int> getDepartureEstimation();
}