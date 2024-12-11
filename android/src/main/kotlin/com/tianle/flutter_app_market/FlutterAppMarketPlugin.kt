package com.tianle.flutter_app_market

import android.content.Context
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** FlutterAppMarketPlugin */
class FlutterAppMarketPlugin : FlutterPlugin, MethodCallHandler {

    private lateinit var channel: MethodChannel
    private var context: Context? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "com.tianle.flutter_app_market")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {

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
                val packageName = call.argument<String?>("uri")
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

            "openOtherApp" -> {
                context?.let { mContext ->
                    val uri = call.argument<String?>("uri")
                    uri?.let {
                        val status = MarketUtils().openOtherApp(mContext, it)
                        result.success(status)
                    }
                }
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
