abstract class IPaymentParticipationProcessService {
  Future<void> updatePayment(String reference) ;
  Future<int> getLastId();
  Future<String>getLastReference();
}