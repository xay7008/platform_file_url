import Flutter
import UIKit

public class SwiftPlatformFileUrlPlugin: NSObject, FlutterPlugin {

  static var platformFileUrlPlugin:SwiftPlatformFileUrlPlugin?=nil;
  var channel:FlutterMethodChannel?=nil;

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "platform_file_url", binaryMessenger: registrar.messenger())
    this.channel=channel
    let instance = SwiftPlatformFileUrlPlugin()
    platformFileUrlPlugin = instance
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }

 func openFile(url:String){
        print("application openFile:"+url)
       channel?.invokeMethod("openFile", arguments:["url":url])
   }
}
