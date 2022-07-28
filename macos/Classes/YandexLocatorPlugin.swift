import Cocoa
import FlutterMacOS
import Foundation
import CoreWLAN

public class YandexLocatorPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "yandex_locator", binaryMessenger: registrar.messenger)
    let instance = YandexLocatorPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
    if let discovery = Discovery() {
        print(discovery.networks)
        for network in discovery.networks {
            print(network.ssid!)
        }
    }
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
        if let discovery = Discovery() {
            print(discovery.networks)
            for network in discovery.networks {
                print(network.rssiValue)
                print(network.bssid)
                print(network.beaconInterval)
            }
        }
        result("macOS " + ProcessInfo.processInfo.operatingSystemVersionString)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
    
    
}

class Discovery {

    var currentInterface: CWInterface
    var interfacesNames: [String] = []
    var networks: Set<CWNetwork> = []

    // Failable init using default interface
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

    // Init with the literal interface name, like "en1"
    init(interfaceWithName name: String) {
        self.currentInterface = CWInterface(interfaceName: name)
        self.interfacesNames.append(name)
        self.findNetworks()
    }

    // Fetch detectable WIFI networks
   func findNetworks() {
        do {
            self.networks = try currentInterface.scanForNetworks(withSSID: nil)
        } catch let error as NSError {
            print("Error: \(error.localizedDescription)")
        }
    }

}
