import Flutter
import UIKit

public class FlutterAppMarketPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "com.tianle.flutter_app_market", binaryMessenger: registrar.messenger())
    let instance = FlutterAppMarketPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
           case "getPlatformVersion":
               result("iOS " + UIDevice.current.systemVersion)
           case "isInstalled":
               let argument = call.arguments as? NSDictionary
               let uri = argument?["uri"]
               if uri != nil {
                   let installed = UIApplication.shared.canOpenURL(URL(string: uri as! String)!)
                   result(installed)
                   return
               }
               result(false)
           case "openOtherApp":
               let argument = call.arguments as? NSDictionary
               let uri = argument?["uri"]
               let url = URL(string: uri as! String)
               if url != nil {
                   if UIApplication.shared.canOpenURL(url!) {
                       UIApplication.shared.open(url!, options: [:]) { _ in
                       }
                       result(true)
                       return
                   }
               }
               result(false)
           default:
               result(FlutterMethodNotImplemented)
           }
        }
}
