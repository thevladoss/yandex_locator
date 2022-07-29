import Flutter
import UIKit
import CoreTelephony

public class SwiftYandexLocatorPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "yandex_locator", binaryMessenger: registrar.messenger())
    let instance = SwiftYandexLocatorPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getAllWifis":
            var wifis = [Array<String>]()
            let networkInfo: CTTelephonyNetworkInfo = CTTelephonyNetworkInfo()
            let ar = networkInfo.subscriberCellularProvider
            if ar != nil {
                print(ar?.mobileCountryCode)
            }
            result(wifis)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}

