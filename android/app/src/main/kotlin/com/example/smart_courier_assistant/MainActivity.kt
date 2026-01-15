package com.example.smart_courier_assistant

import android.content.Intent
import android.net.Uri
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


class MainActivity : FlutterActivity(){
    private val CHANNEL = "com.example.app/native";

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "openDialer" -> {
                    val phoneNumber = call.argument<String>("phoneNumber")
                    if (phoneNumber != null) openDialer(phoneNumber)
                    result.success(null)
                }
                "openWhatsAppChat" -> {
                    val phone = call.argument<String>("phoneNumber")
                    if (!phone.isNullOrEmpty()) openWhatsAppChat(phone)
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun openDialer(phoneNumber: String){
        val intent = Intent(Intent.ACTION_DIAL)
        intent.data = Uri.parse("tel:$phoneNumber")
        startActivity(intent)
    }

    private fun openWhatsAppChat(phone: String){
        val cleanPhone = phone.filter { it.isDigit() }
        val intent = Intent(
        Intent.ACTION_VIEW,
        Uri.parse("https://wa.me/$cleanPhone")
    )
    startActivity(intent)
    }
}
