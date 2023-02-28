import 'flutter_app_market_platform_interface.dart';

class FlutterAppMarket {
  Future<String?> getPlatformVersion() {
    return FlutterAppMarketPlatform.instance.getPlatformVersion();
  }

  Future<void> openMarket({
    String? schemaUrl,
    String? packageName,
    String? marketPackageName,
  }) async {
    FlutterAppMarketPlatform.instance.openMarket(
      schemaUrl: schemaUrl,
      packageName: packageName,
      marketPackageName: marketPackageName,
    );
  }
}
