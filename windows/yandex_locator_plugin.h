#ifndef FLUTTER_PLUGIN_YANDEX_LOCATOR_PLUGIN_H_
#define FLUTTER_PLUGIN_YANDEX_LOCATOR_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace yandex_locator {

class YandexLocatorPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  YandexLocatorPlugin();

  virtual ~YandexLocatorPlugin();

  // Disallow copy and assign.
  YandexLocatorPlugin(const YandexLocatorPlugin&) = delete;
  YandexLocatorPlugin& operator=(const YandexLocatorPlugin&) = delete;

 private:
  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace yandex_locator

#endif  // FLUTTER_PLUGIN_YANDEX_LOCATOR_PLUGIN_H_
