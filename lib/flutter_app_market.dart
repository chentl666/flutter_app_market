import 'flutter_app_market_platform_interface.dart';

class FlutterAppMarket {
  /// 打开应用市场
  Future<void> openMarket({
    String? schemaUrl,
    String? updateAppPackageName,
    String? marketPackageName,
  }) async {
    FlutterAppMarketPlatform.instance.openMarket(
      schemaUrl: schemaUrl,
      packageName: updateAppPackageName,
      marketPackageName: marketPackageName,
    );
  }

  /// 是否安装应用
  Future<bool?> isInstalled(String? packageName) async {
    return await FlutterAppMarketPlatform.instance.isInstalled(
      packageName: packageName,
    );
  }

  /// 获取 android.os.Build.MODEL
  Future<String?> getAndroidModel() async {
    return await FlutterAppMarketPlatform.instance.model();
  }

  /// 获取 android.os.Build.MANUFACTURER
  Future<String?> getAndroidManufacturer() async {
    return await FlutterAppMarketPlatform.instance.manufacturer();
  }

  String? getPackageName(String brand) {
    String? packageName;
    switch (brand) {
      case 'google':
        packageName = 'com.android.vending';
        break;
      case 'tencent':
        packageName = 'com.tencent.android.qqdownloader';
        break;
      case 'huawei':
        packageName = 'com.huawei.appmarket';
        break;
      case 'honor':
        packageName = 'com.huawei.appmarket';
        break;
      case 'oppo':
        packageName = 'com.oppo.market';
        break;
      case 'vivo':
        packageName = 'com.bbk.appstore';
        break;
      case 'xiaomi':
        packageName = 'com.xiaomi.market';
        break;
      case 'meizu':
        packageName = 'com.meizu.mstore';
        break;
      case 'lenovo':
        packageName = 'com.lenovo.leos.appstore';
        break;
      case 'zte':
        packageName = 'zte.com.market';
        break;
      case 'nubia':
        packageName = 'com.nubia.neostore';
        break;
      case 'baidu':
        packageName = 'com.baidu.appsearch';
        break;
    }
    return packageName;
  }
}
