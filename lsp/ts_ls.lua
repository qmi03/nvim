-- tsserver with Vue plugin
local vue_language_server_path =
  "/etc/profiles/per-user/qmi/bin/vue-language-server"
return {
  init_options = {
    plugins = {
      name = "@vue/typescript-plugin",
      location = vue_language_server_path,
      languages = { "vue" },
    },
  },
}
