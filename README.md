# platform_file_url

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/developing-packages/),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

win add
\windows\runner\flutter_windown.h
'''
#include <memory>

#include <argument_vector_handler/argument_vector_handler_plugin.h>

#include "win32_window.h"

// A window that does nothing but host a Flutter view.
class FlutterWindow : public Win32Window {
 public:
  flutter::FlutterViewController* flutter_controller() const {
    return flutter_controller_.get();
  }

  explicit FlutterWindow(const flutter::DartProject& project);
  virtual ~FlutterWindow();
'''

\windows\runner\main.cpp
'''

#include <thread>


int APIENTRY wWinMain(_In_ HINSTANCE instance, _In_opt_ HINSTANCE prev,
                      _In_ wchar_t* command_line, _In_ int show_command) {
  HWND hwnd = ::FindWindow(L"FLUTTER_RUNNER_WIN32_WINDOW", L"input you project name");
  if (hwnd != NULL) {
    ::ShowWindow(hwnd, SW_NORMAL);
    ::SetForegroundWindow(hwnd);
    std::vector<std::string> command_line_arguments = GetCommandLineArguments();
    if (!command_line_arguments.empty()) {
      // TODO: Only sends first argument currently.
      COPYDATASTRUCT cds;
      cds.dwData = 1;
      cds.cbData =
          static_cast<DWORD>(command_line_arguments.front().size() + 1);
      cds.lpData = reinterpret_cast<void*>(
          const_cast<char*>(command_line_arguments.front().c_str()));
      ::SendMessageW(hwnd, WM_COPYDATA, NULL, (LPARAM)&cds);
    }
    std::this_thread::sleep_for(std::chrono::seconds(10));
    return EXIT_FAILURE;
  }

  if (!::AttachConsole(ATTACH_PARENT_PROCESS) && ::IsDebuggerPresent()) {
    CreateAndAttachConsole();
  }

'''
