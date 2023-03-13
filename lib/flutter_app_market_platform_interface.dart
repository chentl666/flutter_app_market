import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_app_market_method_channel.dart';

abstract class FlutterAppMarketPlatform extends PlatformInterface {
  /// Constructs a FlutterAppMarketPlatform.
  FlutterAppMarketPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterAppMarketPlatform _instance = MethodChannelFlutterAppMarket();

  /// The default instance of [FlutterAppMarketPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterAppMarket].
  static FlutterAppMarketPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterAppMarketPlatform] when
  /// they register themselves.
  static set instance(FlutterAppMarketPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
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
