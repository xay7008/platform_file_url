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

    func openFile(url: URL) -> Bool {
        let shouldStopAccessing = url.startAccessingSecurityScopedResource()
        
        // 获取沙盒目录中的目标路径
        let fileManager = FileManager.default
        let tempDirectory = fileManager.temporaryDirectory
        let destinationURL = tempDirectory.appendingPathComponent(url.lastPathComponent)

        // 复制文件
        do {
            // 如果目标位置已经有文件，先移除它
            if fileManager.fileExists(atPath: destinationURL.path) {
                try fileManager.removeItem(at: destinationURL)
            }
            try fileManager.copyItem(at: url, to: destinationURL)
        } catch {
            print("复制文件错误: \(error)")
            url.stopAccessingSecurityScopedResource()
            return false
        }
        
        // 停止访问安全作用域资源
        if shouldStopAccessing {
            url.stopAccessingSecurityScopedResource()
        }
        
        // 将新路径传递给 Flutter
        channel.invokeMethod("openFile", arguments: ["url": destinationURL.path])
        
        return true
    }


    public func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
           // Ensure that the URL is a file URL
            guard url.isFileURL else { return false }

            // Start accessing the security-scoped resource
            let shouldStopAccessing = url.startAccessingSecurityScopedResource()

            // Pass the entire URL to Flutter
            let success = openFile(url: url)

            // Stop accessing the security-scoped resource
            if shouldStopAccessing {
                url.stopAccessingSecurityScopedResource()
            }

            return success
    }
    


}
