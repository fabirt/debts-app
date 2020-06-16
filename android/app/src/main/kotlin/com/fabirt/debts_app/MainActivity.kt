package com.fabirt.debts_app

import android.widget.Toast
import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity(), MethodChannel.MethodCallHandler {
    private lateinit var callbackChannel: MethodChannel

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        callbackChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, METHOD_CHANNEL_NAME).apply {
            setMethodCallHandler(this@MainActivity)
        }
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when(call.method) {
            "showNotification" -> {
                val message: String? = call.argument("message")
                Toast.makeText(this, message, Toast.LENGTH_SHORT).show()
                result.success(null)
            }
            else -> result.success(null)
        }
    }
}
