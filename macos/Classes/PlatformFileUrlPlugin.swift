import Cocoa
import FlutterMacOS

public class PlatformFileUrlPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "platform_file_url", binaryMessenger: registrar.messenger)
    let instance = PlatformFileUrlPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("macOS " + ProcessInfo.processInfo.operatingSystemVersionString)
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  func openFile(url:String){
         channel.invokeMethod("openFile", arguments:["url":url])
     }
}
