import Flutter
import UIKit

public class SwiftPlatformFileUrlPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "platform_file_url", binaryMessenger: registrar.messenger())
    let instance = SwiftPlatformFileUrlPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }

 func openFile(url:String){
        print("application openFile:"+url)
       channel.invokeMethod("openFile", arguments:["url":url])
   }
}
