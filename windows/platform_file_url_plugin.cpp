#pragma once

#include "include/platform_file_url/platform_file_url_plugin.h"

// This must be included before many other Windows headers.
#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/standard_method_codec.h>

namespace {

class PlatformFileUrlPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows* registrar);

  PlatformFileUrlPlugin(flutter::PluginRegistrarWindows* registrar);

  virtual ~PlatformFileUrlPlugin();

 private:
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue>& method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);

  std::string GetErrorString(std::string method_name);

  flutter::PluginRegistrarWindows* registrar_;
  std::unique_ptr<flutter::MethodChannel<flutter::EncodableValue>> channel_;
};

void PlatformFileUrlPlugin::RegisterWithRegistrar(
    flutter::PluginRegistrarWindows* registrar) {
  auto plugin = std::make_unique<PlatformFileUrlPlugin>(registrar);
  registrar->AddPlugin(std::move(plugin));
}

PlatformFileUrlPlugin::PlatformFileUrlPlugin(
    flutter::PluginRegistrarWindows* registrar)
    : registrar_(registrar) {
  channel_ = std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
      registrar_->messenger(), "com.xay/platform_file_url",
      &flutter::StandardMethodCodec::GetInstance());
  channel_->SetMethodCallHandler([this](const auto& call, auto result) {
    HandleMethodCall(call, std::move(result));
  });
  registrar_->RegisterTopLevelWindowProcDelegate([=](HWND hwnd, UINT message,
                                                     WPARAM wparam,
                                                     LPARAM lparam)
                                                     -> std::optional<HRESULT> {
    {
      switch (message) {
        case WM_COPYDATA: {
          channel_->InvokeMethod(
              //std::string(),
              "openFile",
              std::make_unique<flutter::EncodableValue>(
                  flutter::EncodableValue(std::string(static_cast<char*>(
                      reinterpret_cast<COPYDATASTRUCT*>(lparam)->lpData)))));
        }
        default:
          break;
      }
      return std::nullopt;
    }
  });
}

PlatformFileUrlPlugin::~PlatformFileUrlPlugin() {}

void PlatformFileUrlPlugin::HandleMethodCall(
    const flutter::MethodCall<flutter::EncodableValue>& method_call,
    std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result) {
  result->NotImplemented();
}
}  // namespace

void PlatformFileUrlPluginRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  PlatformFileUrlPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
