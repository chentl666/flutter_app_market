import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_app_market_method_channel.dart';

abstract class FlutterAppMarketPlatform extends PlatformInterface {
  FlutterAppMarketPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterAppMarketPlatform _instance = MethodChannelFlutterAppMarket();

  static FlutterAppMarketPlatform get instance => _instance;

  static set instance(FlutterAppMarketPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> openMarket({
    String? schemaUrl,
    String? packageName,
    String? marketPackageName,
  });

  Future<bool?> isInstalled({
    String? packageName,
  });

  Future<String?> model();

  Future<String?> manufacturer();
}
