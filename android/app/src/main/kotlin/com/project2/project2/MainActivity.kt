package com.project2.project2

import android.os.Build
import android.os.Bundle
import android.view.WindowManager
import androidx.core.app.NotificationManagerCompat
import io.flutter.embedding.android.FlutterFragmentActivity // Changed import
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterFragmentActivity() { // Changed from FlutterActivity to FlutterFragmentActivity
    private val CHANNEL = "screenshot_channel"
    private lateinit var channel: MethodChannel

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
        channel.setMethodCallHandler { call, result ->
            when (call.method) {
                "preventScreenshots" -> {
                    runOnUiThread {
                        window.addFlags(WindowManager.LayoutParams.FLAG_SECURE)
                        result.success(true)
                    }
                }
                "allowScreenshots" -> {
                    runOnUiThread {
                        window.clearFlags(WindowManager.LayoutParams.FLAG_SECURE)
                        result.success(true)
                    }
                }
                else -> result.notImplemented()
            }
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Notification permission for Android 13+
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            NotificationManagerCompat.from(this).areNotificationsEnabled().let { enabled ->
                if (!enabled) {
                    requestPermissions(arrayOf(android.Manifest.permission.POST_NOTIFICATIONS), 0)
                }
            }
        }
    }
}