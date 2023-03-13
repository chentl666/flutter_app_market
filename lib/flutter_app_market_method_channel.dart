import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_app_market_platform_interface.dart';

/// An implementation of [FlutterAppMarketPlatform] that uses method channels.
class MethodChannelFlutterAppMarket extends FlutterAppMarketPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('com.tianle.flutter_app_market');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<void> openMarket(
      {String? schemaUrl,
      String? packageName,
      String? marketPackageName}) async {
    await methodChannel.invokeMethod<void>('openMarket', {
      'schemaUrl': schemaUrl,
      'packageName': packageName,
      'marketPackageName': marketPackageName,
    });
  }

  @override
  Future<bool?> isInstalled({String? packageName}) async {
    return await methodChannel
        .invokeMethod<bool?>('isInstalled', {'packageName': packageName});
  }

  @override
  Future<String?> model() async {
    return await methodChannel.invokeMethod<String?>('model');
  }

  @override
  Future<String?> manufacturer() async {
    return await methodChannel.invokeMethod<String?>('manufacturer');
  }
}
