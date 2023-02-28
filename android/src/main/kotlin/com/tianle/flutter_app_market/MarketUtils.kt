package com.tianle.flutter_app_market

import android.content.ActivityNotFoundException
import android.content.Context
import android.content.Intent
import android.content.pm.PackageInfo
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Build
import android.text.TextUtils
import android.util.Log
import java.util.*

/**
 * 各大应用市场工具类
 */
class MarketUtils {

    companion object {
        var tools: MarketUtils? = null
            get() {
                if (null == field) {
                    field = MarketUtils()
                }
                return field
            }
            private set
        private const val schemaUrl = "market://details?id="
    }

    /***
     * 打开应用市场
     */
    fun startMarket(mContext: Context, packageName: String?, marketPackageName: String?, schema: String?) {
        try {
            var mPackageName = packageName
            var mMarketPackageName = marketPackageName
            if (mPackageName == null) {
                mPackageName = mContext.packageName //得到包名
            }
            if (!mPackageName.isNullOrBlank()) {
                if (mMarketPackageName == null) {
                    val brandName = Build.BRAND.uppercase(Locale.getDefault()) //大写
                    if (!TextUtils.isEmpty(brandName)) {
                        mMarketPackageName = getBrandName(brandName)
                    } else {
                        Log.e("MarketUtils", "没有读取到手机厂商~~")
                    }
//                    if (mMarketPackageName == null) {
//                        val isExit1 = isCheckBaiduOrYYB(mContext, PackageNameConst.BAIDU_PACKAGE_NAME)
//                        if (isExit1) {
//                            mMarketPackageName = PackageNameConst.BAIDU_PACKAGE_NAME
//                        }
//                        val isExit2 = isCheckBaiduOrYYB(mContext, PackageNameConst.TENCENT_PACKAGE_NAME)
//                        if (isExit2) {
//                            mMarketPackageName = PackageNameConst.TENCENT_PACKAGE_NAME
//                        }
//                    }
                }
                openMarket(mContext, mPackageName, mMarketPackageName, schema)
            }
        } catch (anf: ActivityNotFoundException) {
            Log.e("MarketUtils", "要跳转的应用市场不存在!")
        } catch (e: Exception) {
            Log.e("MarketUtils", "其他错误：" + e.message)
        }
    }

    private fun openMarket(mContext: Context, packageName: String, marketPackageName: String?, schema: String?) {
        try {
            val mSchema = schema ?: schemaUrl
            val uri = Uri.parse(mSchema + packageName)
            val intent = Intent(Intent.ACTION_VIEW, uri)
            intent.setPackage(marketPackageName)
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            mContext.startActivity(intent)
        } catch (anf: ActivityNotFoundException) {
            Log.e("MarketUtils", "要跳转的应用市场不存在!")
        } catch (e: Exception) {
            Log.e("MarketUtils", "其他错误：" + e.message)
        }
    }

    /****
     * 检查APP是否安装成功
     */
    private fun isInstalled(context: Context, packageName: String): Boolean {
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

    private fun getBrandName(brandName: String): String? {
        if (BrandConst.HUAWEI_BRAND == brandName) {
            //华为
            return PackageNameConst.HUAWEI_PACKAGE_NAME
        } else if (BrandConst.OPPO_BRAND == brandName) {
            //oppo
            return PackageNameConst.OPPO_PACKAGE_NAME
        } else if (BrandConst.VIVO_BRAND == brandName) {
            //vivo
            return PackageNameConst.VIVO_PACKAGE_NAME
        } else if (BrandConst.XIAOMI_BRAND == brandName) {
            //小米
            return PackageNameConst.XIAOMI_PACKAGE_NAME
        } else if (BrandConst.LENOVO_BRAND == brandName) {
            //联想
            return PackageNameConst.LIANXIANG_PACKAGE_NAME
        } else if (BrandConst.QH360_BRAND == brandName) {
            //360
            return PackageNameConst.QH360_PACKAGE_NAME
        } else if (BrandConst.MEIZU_BRAND == brandName) {
            //魅族
            return PackageNameConst.MEIZU_PACKAGE_NAME
        } else if (BrandConst.HONOR_BRAND == brandName) {
            //华为
            return PackageNameConst.HUAWEI_PACKAGE_NAME
        } else if (BrandConst.XIAOLAJIAO_BRAND == brandName) {
            //小辣椒
            return PackageNameConst.ZHUOYI_PACKAGE_NAME
        } else if (BrandConst.ZTE_BRAND == brandName) {
            //zte
            return PackageNameConst.ZTE_PACKAGE_NAME
        } else if (BrandConst.NIUBIA_BRAND == brandName) {
            //努比亚
            return PackageNameConst.NIUBIA_PACKAGE_NAME
        } else if (BrandConst.ONE_PLUS_BRAND == brandName) {
            //OnePlus
            return PackageNameConst.OPPO_PACKAGE_NAME
        } else if (BrandConst.MEITU_BRAND == brandName) {
            //美图
            return PackageNameConst.MEITU_PACKAGE_NAME
        } else if (BrandConst.SONY_BRAND == brandName) {
            //索尼
            return PackageNameConst.GOOGLE_PACKAGE_NAME
        } else if (BrandConst.GOOGLE_BRAND == brandName) {
            //google
            return PackageNameConst.GOOGLE_PACKAGE_NAME
        }
        return null
    }


}