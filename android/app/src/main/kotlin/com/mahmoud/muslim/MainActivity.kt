package com.mahmoud.muslim

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.os.Build
import android.os.PowerManager
import android.provider.Settings
import android.util.Log
import android.graphics.Color
import com.ryanheise.audioservice.AudioServiceActivity
import androidx.core.view.WindowCompat

class MainActivity : AudioServiceActivity() {
    private val notificationChannel = "com.mahmoud.muslim/notification_click"
    private val batteryChannel = "com.mahmoud.muslim/battery_optimization"

    override fun onCreate(savedInstanceState: Bundle?) {
        WindowCompat.setDecorFitsSystemWindows(window, false)
        window.statusBarColor = Color.TRANSPARENT
        window.navigationBarColor = Color.TRANSPARENT

        super.onCreate(savedInstanceState)
        handleIntent(intent)
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        handleIntent(intent)
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // --- Notification click channel ---
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            notificationChannel,
        ).setMethodCallHandler { call, result ->
            if (call.method == "onNotificationClick") {
                result.success(null)
            } else {
                result.notImplemented()
            }
        }

        // --- Battery optimization channel ---
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            batteryChannel,
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "isIgnoringBatteryOptimizations" -> {
                    val pm = getSystemService(POWER_SERVICE) as PowerManager
                    result.success(pm.isIgnoringBatteryOptimizations(packageName))
                }
                "requestIgnoreBatteryOptimizations" -> {
                    try {
                        val intent = Intent(
                            Settings.ACTION_REQUEST_IGNORE_BATTERY_OPTIMIZATIONS,
                            Uri.parse("package:$packageName"),
                        )
                        startActivity(intent)
                        result.success(null)
                    } catch (e: Exception) {
                        // Fallback: open general battery settings
                        try {
                            startActivity(Intent(Settings.ACTION_IGNORE_BATTERY_OPTIMIZATION_SETTINGS))
                            result.success(null)
                        } catch (e2: Exception) {
                            result.error("UNAVAILABLE", e2.message, null)
                        }
                    }
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun handleIntent(intent: Intent?) {
        Log.d("MainActivity", "Handle Intent Action: ${intent?.action}")
        Log.d("MainActivity", "Intent Extras: ${intent?.extras?.keySet()?.joinToString(", ")}")

        if (intent?.action != Intent.ACTION_MAIN) {
            Log.d("MainActivity", "Triggering MethodChannel onNotificationClick")
            flutterEngine?.dartExecutor?.binaryMessenger?.let {
                MethodChannel(it, notificationChannel).invokeMethod("onNotificationClick", null)
            } ?: Log.e("MainActivity", "FlutterEngine or BinaryMessenger is NULL")
        }
    }
}
