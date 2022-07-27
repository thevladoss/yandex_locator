//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <yandex_locator/yandex_locator_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) yandex_locator_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "YandexLocatorPlugin");
  yandex_locator_plugin_register_with_registrar(yandex_locator_registrar);
}
