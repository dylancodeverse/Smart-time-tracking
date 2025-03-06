import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// Initialisation du service de notification
  static Future<void> initialize() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher'); // Icône pour Android

    const InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
    );

    await _notificationsPlugin.initialize(initializationSettings);
  }

  /// Demander l'autorisation pour les notifications sur Android 13+
  static Future<void> requestAndroid13Permission() async {
    if (Platform.isAndroid && await Permission.notification.isDenied) {
      // Demande la permission d'envoyer des notifications
      await Permission.notification.request();
    }
  }

  /// Afficher une notification
  static Future<void> showNotification({
    required String title,
    required String body,
  }) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'update_channel', // ID du canal
      'Mises à jour', // Nom du canal
      channelDescription: 'Notifications de mise à jour des données',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails);

    await _notificationsPlugin.show(
      0, // ID unique de la notification
      title, // Titre
      body, // Contenu
      notificationDetails,
    );
  }
}
