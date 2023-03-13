import 'flutter_app_market_platform_interface.dart';

class FlutterAppMarket {
  Future<String?> getPlatformVersion() {
    return FlutterAppMarketPlatform.instance.getPlatformVersion();
  }

  /// 打开应用市场
  Future<void> openMarket({
    String? schemaUrl,
    String? updateAppPackageName,
    String? marketPackageName,
    Brand? marketBrand,
  }) async {
    String? mpn = marketPackageName;
    if (marketBrand != null) {
      mpn = getPackageName(marketBrand);
    }
    FlutterAppMarketPlatform.instance.openMarket(
      schemaUrl: schemaUrl,
      packageName: updateAppPackageName,
      marketPackageName: mpn,
    );
  }

  /// 是否安装应用
  Future<bool?> isInstalled({
    String? packageName,
    Brand? brand,
  }) async {
    String? mPackageName = packageName;
    if (brand != null) {
      mPackageName = getPackageName(brand);
    }
    return await FlutterAppMarketPlatform.instance.isInstalled(
      packageName: mPackageName,
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
}

enum Brand {
  google,
  tencent,
  huawei,
  honor,
  oppo,
  vivo,
  xiaomi,
  meizu,
  lenovo,
  zte,
  phone360,
  nubia,
  meitu,
  baidu,
}

String? getPackageName(Brand brand) {
  String? packageName;
  switch (brand) {
    case Brand.google:
      packageName = 'com.android.vending';
      break;
    case Brand.tencent:
      packageName = 'com.tencent.android.qqdownloader';
      break;
    case Brand.huawei:
      packageName = 'com.huawei.appmarket';
      break;
    case Brand.honor:
      packageName = 'com.huawei.appmarket';
      break;
    case Brand.oppo:
      packageName = 'com.oppo.market';
      break;
    case Brand.vivo:
      packageName = 'com.bbk.appstore';
      break;
    case Brand.xiaomi:
      packageName = 'com.xiaomi.market';
      break;
    case Brand.meizu:
      packageName = 'com.meizu.mstore';
      break;
    case Brand.lenovo:
      packageName = 'com.lenovo.leos.appstore';
      break;
    case Brand.zte:
      packageName = 'zte.com.market';
      break;
    case Brand.phone360:
      packageName = 'com.qihoo.appstore';
      break;
    case Brand.nubia:
      packageName = 'com.nubia.neostore';
      break;
    case Brand.meitu:
      packageName = 'com.android.mobile.appstore';
      break;
    case Brand.baidu:
      packageName = 'com.baidu.appsearch';
      break;
  }
  return packageName;
}
