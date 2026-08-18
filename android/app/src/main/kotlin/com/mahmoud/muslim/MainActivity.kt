package com.mahmoud.muslim

import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.Intent
import android.os.Bundle
import android.os.Build
import android.util.Log
import android.graphics.Color
import com.ryanheise.audioservice.AudioServiceActivity
import androidx.core.view.WindowCompat


class MainActivity : AudioServiceActivity() {
    private val CHANNEL = "com.mahmoud.muslim/notification_click"

    override fun onCreate(savedInstanceState: Bundle?) {
        // Enable edge-to-edge display
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

    private fun handleIntent(intent: Intent?) {
        Log.d("MainActivity", "Handle Intent Action: ${intent?.action}")
        Log.d("MainActivity", "Intent Extras: ${intent?.extras?.keySet()?.joinToString(", ")}")
        
        // Only trigger deep link if it's NOT a standard launcher launch
        if (intent?.action != Intent.ACTION_MAIN) {
            Log.d("MainActivity", "Triggering MethodChannel onNotificationClick")
            flutterEngine?.dartExecutor?.binaryMessenger?.let {
                MethodChannel(it, CHANNEL).invokeMethod("onNotificationClick", null)
            } ?: Log.e("MainActivity", "FlutterEngine or BinaryMessenger is NULL")
        }
    }
}
