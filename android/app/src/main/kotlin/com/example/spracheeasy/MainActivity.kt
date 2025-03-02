package com.example.sola

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.provider.Settings
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import android.util.Log


class MainActivity: FlutterActivity() {
    private val TIME_EVENT_CHANNEL = "com.example.sola/timeEvents"
    private val SETTINGS_METHOD_CHANNEL = "com.example.sola/settings"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Configuration du EventChannel pour écouter les changements en temps réel
        EventChannel(flutterEngine.dartExecutor.binaryMessenger, TIME_EVENT_CHANNEL)
            .setStreamHandler(TimeEventHandler(applicationContext))

        // Configuration du MethodChannel pour gérer les appels depuis Flutter
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, SETTINGS_METHOD_CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "isAutoTimeEnabled" -> {
                        try {
                            val isAutoTimeEnabled = Settings.Global.getInt(contentResolver, Settings.Global.AUTO_TIME, 0) == 1
                            result.success(isAutoTimeEnabled)
                        } catch (e: Exception) {
                            result.error("UNAVAILABLE", "Erreur lors de la récupération de l'heure automatique", null)
                        }
                    }

                    "openAutoTimeSettings" -> {
                        try {
                            val intent = Intent(Settings.ACTION_DATE_SETTINGS)
                            intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
                            startActivity(intent)
                            result.success(null) // Indique que l'opération a réussi
                        } catch (e: Exception) {
                            result.error("UNAVAILABLE", "Impossible d'ouvrir les paramètres de date/heure", null)
                        }
                    }

                    else -> result.notImplemented()
                }
            }
    }
}

class TimeEventHandler(private val context: Context) : EventChannel.StreamHandler {
    private var receiver: BroadcastReceiver? = null

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        receiver = object : BroadcastReceiver() {
            override fun onReceive(context: Context?, intent: Intent?) {
                Log.d("TimeEventHandler", "Intent reçu: ${intent?.action}")
                println("Intent reçu: ${intent?.action}") // Affiché dans Logcat sous System.out

                val isAutoTimeEnabled = try {
                    Settings.Global.getInt(context?.contentResolver, Settings.Global.AUTO_TIME, 0) == 1
                } catch (e: Exception) {
                    false
                }
                events?.success(isAutoTimeEnabled)
            }
        }

        val filter = IntentFilter().apply {
            addAction(Intent.ACTION_TIME_CHANGED)   // Changement d'heure
            addAction(Intent.ACTION_TIMEZONE_CHANGED) // Changement de fuseau horaire
            // Pas besoin d'un addAction() vide
        }

        Log.d("TimeEventHandler", "Essai d'enregistrement du receiver")
        context.registerReceiver(receiver, filter)
        Log.d("TimeEventHandler", "Receiver enregistré")
    }

    override fun onCancel(arguments: Any?) {
        receiver?.let { context.unregisterReceiver(it) }
        receiver = null
    }
}
