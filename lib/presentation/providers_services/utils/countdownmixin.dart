import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sola/lib/date_helper.dart';

mixin CountdownMixin on ChangeNotifier {
  late DateTime targetDateTime;
  late Timer _timer;
  late Duration remainingTime = Duration.zero;

  void initializeCountdown(String timeString) {
    try {
      targetDateTime = Date.convertStringToDateTime(timeString);
    } catch (e) {
      // donc le target doit etre maintenant 
      targetDateTime = DateTime.now();
    }
      _startCountdown();

  }



  void _startCountdown() {
    _updateRemainingTime();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime.inSeconds <= 0) {
        timer.cancel();
      } else {
        _updateRemainingTime();
        notifyListeners();
      }
    });
  }

  void _updateRemainingTime() {
    DateTime now = DateTime.now();
    remainingTime = targetDateTime.difference(now);
    if (remainingTime.isNegative) {
      remainingTime = Duration.zero;
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
