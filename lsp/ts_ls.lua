-- tsserver with Vue plugin
local vue_language_server_path =
"/etc/profiles/per-user/qmi/bin/vue-language-server"
local vue_plugin = {
  name = '@vue/typescript-plugin',
  location = vue_language_server_path,
  languages = { 'vue' },
  configNamespace = 'typescript',
}
return {
  init_options = {
    plugins = {
      vue_plugin,
    },
  },
}
