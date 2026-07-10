package com.example.myket_updater

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

class MyketUpdaterPlugin : FlutterPlugin, MethodCallHandler {

    private lateinit var channel: MethodChannel
    private var handler: MyketUpdaterHandler? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "myket_updater")
        channel.setMethodCallHandler(this)
        handler = MyketUpdaterHandler(flutterPluginBinding.applicationContext)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "checkForUpdate" -> {
                handler?.checkForUpdate(result) ?: result.error("HANDLER_NULL", "Plugin handler not initialized", null)
            }
            "openMyketPage" -> {
                handler?.openMyketPage(result) ?: result.error("HANDLER_NULL", "Plugin handler not initialized", null)
            }
            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
        handler?.dispose()
        handler = null
    }
}
