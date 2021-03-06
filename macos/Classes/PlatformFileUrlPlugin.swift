import Cocoa
import FlutterMacOS

public class PlatformFileUrlPlugin: NSObject, FlutterPlugin {

  static var platformFileUrlPlugin:PlatformFileUrlPlugin?=nil;
  //var channell:FlutterMethodChannel?=nil;

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "platform_file_url", binaryMessenger: registrar.messenger)
    //channell = channel
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
         //channell?.invokeMethod("openFile", arguments:["url":url])
     }
}
