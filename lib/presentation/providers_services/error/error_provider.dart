import 'package:flutter/material.dart';

class ErrorProvider with ChangeNotifier {
  String? _lastError; // Stocke le dernier message d'erreur
  StackTrace? _lastStackTrace; // Stocke la stack trace

  String? get lastError => _lastError;
  StackTrace? get lastStackTrace => _lastStackTrace;

  // Méthode pour enregistrer une erreur
  void setError(String error, StackTrace stackTrace) {
    _lastError = error;
    _lastStackTrace = stackTrace;
    notifyListeners(); // Notifie les consommateurs du provider
  }

  // Méthode pour effacer l'erreur
  void clearError() {
    _lastError = null;
    _lastStackTrace = null;
    notifyListeners();
  }
}
