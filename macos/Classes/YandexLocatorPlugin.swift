import Cocoa
import FlutterMacOS
import Foundation
import CoreWLAN

public class YandexLocatorPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "yandex_locator", binaryMessenger: registrar.messenger)
        let instance = YandexLocatorPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getAllWifis":
            var wifis = [Array<String>]()
            if let discovery = Discovery() {
                for network in discovery.networks {
                    var wifi = [String]()
                    wifi.append(network.bssid ?? "")
                    wifi.append(String(network.rssiValue))
                    wifi.append(String(network.beaconInterval))
                    wifis.append(wifi)
                }
            }
            result(wifis)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}


class Discovery {

    var currentInterface: CWInterface
    var interfacesNames: [String] = []
    var networks: Set<CWNetwork> = []

    init?() {
        if let defaultInterface = CWWiFiClient.shared().interface(),
               let name = defaultInterface.interfaceName {
            self.currentInterface = defaultInterface
            self.interfacesNames.append(name)
            self.findNetworks()
        } else {
            return nil
        }
    }

    init(interfaceWithName name: String) {
        self.currentInterface = CWInterface(interfaceName: name)
        self.interfacesNames.append(name)
        self.findNetworks()
    }

   func findNetworks() {
        do {
            self.networks = try currentInterface.scanForNetworks(withSSID: nil)
        } catch let error as NSError {
            print("Error: \(error.localizedDescription)")
        }
    }
}
