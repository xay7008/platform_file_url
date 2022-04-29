
import 'dart:async';

import 'package:flutter/services.dart';

class PlatformFileUrl {
  static const MethodChannel _channel = MethodChannel('platform_file_url');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
