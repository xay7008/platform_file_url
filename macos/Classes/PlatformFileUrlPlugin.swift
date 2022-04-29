import Cocoa
import FlutterMacOS

public class PlatformFileUrlPlugin: NSObject, FlutterPlugin {

  static var platformFileUrlPlugin:PlatformFileUrlPlugin?=nil;
  var channel:FlutterMethodChannel?=nil;

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "platform_file_url", binaryMessenger: registrar.messenger)
    self.channel=channel
    let instance = PlatformFileUrlPlugin()
    platformFileUrlPlugin = instance
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
         channel?.invokeMethod("openFile", arguments:["url":url])
     }
}
