package com.tianle.flutter_app_market

import android.content.ActivityNotFoundException
import android.content.Context
import android.content.Intent
import android.content.pm.PackageInfo
import android.content.pm.PackageManager
import android.net.Uri
import android.util.Log

/**
 * 各大应用市场工具类
 */
class MarketUtils {

    companion object {
        private const val schemaUrl = "market://details?id="
        private const val TAG = "flutter_app_market"
    }

    /***
     * 打开应用市场
     */
    fun startMarket(mContext: Context, packageName: String?, marketPackageName: String?, schema: String?) {
        try {
            var mPackageName = packageName
            if (mPackageName == null) {
                mPackageName = mContext.packageName //得到包名
            }
            if (!mPackageName.isNullOrBlank()) {
                openMarket(mContext, mPackageName, marketPackageName, schema)
            }
        } catch (anf: ActivityNotFoundException) {
            Log.e(TAG, "要跳转的应用市场不存在!")
        } catch (e: Exception) {
            Log.e(TAG, "其他错误：" + e.message)
        }
    }

    private fun openMarket(mContext: Context, packageName: String, marketPackageName: String?, schema: String?) {
        try {
            val mSchema = schema ?: schemaUrl
            val uri = Uri.parse(mSchema + packageName)
            val intent = Intent(Intent.ACTION_VIEW, uri)
            if (marketPackageName != null) {
                intent.setPackage(marketPackageName)
            }
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            if (intent.resolveActivity(mContext.packageManager) != null) {
                mContext.startActivity(intent)
            }
        } catch (anf: ActivityNotFoundException) {
            Log.e(TAG, "要跳转的应用市场不存在!")
        } catch (e: Exception) {
            Log.e(TAG, "其他错误：" + e.message)
        }
    }

    /****
     * 检查APP是否安装成功
     */
    fun isInstalled(context: Context, packageName: String): Boolean {
        if ("" == packageName || packageName.isEmpty()) {
            return false
        }
        val packageInfo: PackageInfo? = try {
            context.packageManager.getPackageInfo(packageName, 0)
        } catch (e: PackageManager.NameNotFoundException) {
            null
        }
        return packageInfo != null
    }

}