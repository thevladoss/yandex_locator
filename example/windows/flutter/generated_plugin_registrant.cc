//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <network_info_plus_windows/network_info_plus_windows_plugin.h>
#include <yandex_locator/yandex_locator_plugin_c_api.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  NetworkInfoPlusWindowsPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("NetworkInfoPlusWindowsPlugin"));
  YandexLocatorPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("YandexLocatorPluginCApi"));
}
