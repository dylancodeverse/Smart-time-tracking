import 'package:flutter/services.dart';

class TimeAutoEvent {
  static const EventChannel _channel = EventChannel('com.example.sola/timeEvents');

  /// Ce flux émet des booléens : `true` si l'heure automatique est activée, sinon `false`
  static Stream<bool> get timeAutoStream =>
      _channel.receiveBroadcastStream().cast<bool>();
}
