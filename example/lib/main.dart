import 'package:flutter/material.dart';
import 'package:flutter_app_market/flutter_app_market.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final plugin = FlutterAppMarket();
  bool? huawei;
  bool? xiaomi;
  bool? tencent;

  @override
  void initState() {
    super.initState();
    plugin.isInstalled(plugin.getPackageName('huawei')).then((res) {
      setState(() {
        huawei = res;
      });
    });
    plugin.isInstalled(plugin.getPackageName('xiaomi')).then((res) {
      setState(() {
        xiaomi = res;
      });
    });
    plugin.isInstalled(plugin.getPackageName('tencent')).then((res) {
      setState(() {
        tencent = res;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('打开应用市场Example'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('华为应用市场是否安装:${huawei}'),
              ElevatedButton(
                onPressed: () {
                  plugin.openMarket(
                      updateAppPackageName: 'com.yhyx.aimeili',
                      marketPackageName: plugin.getPackageName('huawei'));
                },
                child: Text('华为应用市场'),
              ),
              Text('小米应用市场是否安装:${xiaomi}'),
              ElevatedButton(
                onPressed: () {
                  plugin.openMarket(
                      updateAppPackageName: 'com.yhyx.aimeili',
                      marketPackageName: plugin.getPackageName('xiaomi'));
                },
                child: Text('小米应用市场'),
              ),
              Text('应用宝是否安装:${tencent}'),
              ElevatedButton(
                onPressed: () {
                  plugin.openMarket(
                      updateAppPackageName: 'com.yhyx.aimeili',
                      marketPackageName: plugin.getPackageName('tencent'));
                },
                child: Text('应用宝'),
              ),
              ElevatedButton(
                onPressed: () {
                  plugin.openOtherApp('weixin://');
                },
                child: Text('打开微信'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
