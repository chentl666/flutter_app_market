import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_app_market_platform_interface.dart';

class MethodChannelFlutterAppMarket extends FlutterAppMarketPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('com.tianle.flutter_app_market');

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
