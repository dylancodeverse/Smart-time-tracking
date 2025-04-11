// Service de vérification d'heure
import 'package:sola/global/time_service.dart';

class TimeCheckService {
  static bool isWithinAllowedHours() {
    final now = DateTime.now();
    return now.hour >= TimeService.hourService && now.hour < TimeService.hourEndService;
  }
}