package com.tianle.flutter_app_market

import android.content.Context
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** FlutterAppMarketPlugin */
class FlutterAppMarketPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private var context: Context? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "com.tianle.flutter_app_market")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "getPlatformVersion" -> {
                result.success("Android ${android.os.Build.VERSION.RELEASE}")
            }
            "openMarket" -> {
                val mContext = context
                val schemaUrl = call.argument<String?>("schemaUrl")
                val packageName = call.argument<String?>("packageName")
                val marketPackageName = call.argument<String?>("marketPackageName")
                if (mContext != null) {
                    MarketUtils().startMarket(mContext, packageName, marketPackageName, schemaUrl)
                }
            }
            "isInstalled" -> {
                val mContext = context
                val packageName = call.argument<String?>("packageName")
                if (mContext != null && packageName != null) {
                    MarketUtils().isInstalled(mContext, packageName).let {
                        result.success(it)
                    }
                }
            }
            "model" -> {
                result.success(android.os.Build.MODEL)
            }
            "manufacturer" -> {
                result.success(android.os.Build.MANUFACTURER)
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
