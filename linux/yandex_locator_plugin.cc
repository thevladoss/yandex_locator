#include "include/yandex_locator/yandex_locator_plugin.h"

#include <flutter_linux/flutter_linux.h>
#include <gtk/gtk.h>
#include <sys/utsname.h>

#include <cstring>

#define YANDEX_LOCATOR_PLUGIN(obj) \
  (G_TYPE_CHECK_INSTANCE_CAST((obj), yandex_locator_plugin_get_type(), \
                              YandexLocatorPlugin))

struct _YandexLocatorPlugin {
  GObject parent_instance;
};

G_DEFINE_TYPE(YandexLocatorPlugin, yandex_locator_plugin, g_object_get_type())

// Called when a method call is received from Flutter.
static void yandex_locator_plugin_handle_method_call(
    YandexLocatorPlugin* self,
    FlMethodCall* method_call) {
  g_autoptr(FlMethodResponse) response = nullptr;

  const gchar* method = fl_method_call_get_name(method_call);

  if (strcmp(method, "getAllWifis") == 0) {
    struct utsname uname_data = {};
    uname(&uname_data);
    g_autofree gchar *version = g_strdup_printf("Linux %s", uname_data.version);
    g_autoptr(FlValue) result = fl_value_new_string(version);
    response = FL_METHOD_RESPONSE(fl_method_success_response_new(result));
  } else {
    response = FL_METHOD_RESPONSE(fl_method_not_implemented_response_new());
  }

  fl_method_call_respond(method_call, response, nullptr);
}

static void yandex_locator_plugin_dispose(GObject* object) {
  G_OBJECT_CLASS(yandex_locator_plugin_parent_class)->dispose(object);
}

static void yandex_locator_plugin_class_init(YandexLocatorPluginClass* klass) {
  G_OBJECT_CLASS(klass)->dispose = yandex_locator_plugin_dispose;
}

static void yandex_locator_plugin_init(YandexLocatorPlugin* self) {}

static void method_call_cb(FlMethodChannel* channel, FlMethodCall* method_call,
                           gpointer user_data) {
  YandexLocatorPlugin* plugin = YANDEX_LOCATOR_PLUGIN(user_data);
  yandex_locator_plugin_handle_method_call(plugin, method_call);
}

void yandex_locator_plugin_register_with_registrar(FlPluginRegistrar* registrar) {
  YandexLocatorPlugin* plugin = YANDEX_LOCATOR_PLUGIN(
      g_object_new(yandex_locator_plugin_get_type(), nullptr));

  g_autoptr(FlStandardMethodCodec) codec = fl_standard_method_codec_new();
  g_autoptr(FlMethodChannel) channel =
      fl_method_channel_new(fl_plugin_registrar_get_messenger(registrar),
                            "yandex_locator",
                            FL_METHOD_CODEC(codec));
  fl_method_channel_set_method_call_handler(channel, method_call_cb,
                                            g_object_ref(plugin),
                                            g_object_unref);

  g_object_unref(plugin);
}
