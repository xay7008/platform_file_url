import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'platform_file_url.dart';

class PlatformFileUrl {
  static const MethodChannel _channel = MethodChannel(
      'com.xay/platform_file_url');
  bool isInitOk = false;
  OnUrlLinten? onUrlLinten;
  static final PlatformFileUrl _singleton = PlatformFileUrl._internal();

  factory PlatformFileUrl() {
    return _singleton;
  }


  PlatformFileUrl._internal();

  init() {
    isInitOk = true;
    _channel.setMethodCallHandler((call) async {
      if (kDebugMode) {
        print(
            "platform_file_url:call.method:${call.method} call arguments:${call
                .arguments}");
      }
      if (call.method == "openFile") {
        if (Platform.isAndroid || Platform.isMacOS || Platform.isIOS) {
          openPlatformFile(call.arguments["url"]);
        } else if (Platform.isWindows) {
          openPlatformFile(call.arguments);
        }
      }
    });
  }

  void addUrlLinten(OnUrlLinten onUrlLinten) {
    this.onUrlLinten = onUrlLinten;
  }

  Future<void> openPlatformFile(String? url) async {
    if (!isInitOk) {
      if (kDebugMode) {
        print("platform_file_url:openPlatformFile not init");
      }
      return;
    }
    if (url == null || url.isEmpty) {
      if (kDebugMode) {
        print("platform_file_url:openPlatformFile url is null");
      }
      return;
    }
    onUrlLinten?.call(url);
  }
}

typedef OnUrlLinten = Function(String url);
