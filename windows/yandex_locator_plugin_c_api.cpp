#include "include/yandex_locator/yandex_locator_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "yandex_locator_plugin.h"

void YandexLocatorPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  yandex_locator::YandexLocatorPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
