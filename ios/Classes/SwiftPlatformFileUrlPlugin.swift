import Flutter
import UIKit

public class SwiftPlatformFileUrlPlugin: NSObject, FlutterPlugin {

  static var platformFileUrlPlugin:SwiftPlatformFileUrlPlugin?=nil;
  var channel:FlutterMethodChannel;

    init(channel: FlutterMethodChannel) {
        self.channel=channel
    }

    
    
  public static func register(with registrar: FlutterPluginRegistrar) {
         print("application Universal init")
    let channel = FlutterMethodChannel(name: "com.xay/platform_file_url", binaryMessenger: registrar.messenger())
    let instance = SwiftPlatformFileUrlPlugin(channel: channel)
    platformFileUrlPlugin = instance
    registrar.addMethodCallDelegate(instance, channel: channel)
    registrar.addApplicationDelegate(instance)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }

  func openFile(url:String)-> Bool{
      print("application openFile:"+url)
      if(url.isEmpty || !url.contains(".cb1")){
          return false
      }
      channel.invokeMethod("openFile", arguments:["url":url])
      return true
   }


    public func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return  openFile(url: url.path)
    }


    public func application(_ application: UIApplication, open url: URL, sourceApplication: String, annotation: Any) -> Bool {
        return openFile(url: url.path)
    }
}
