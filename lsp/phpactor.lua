-- get binary path
local get_binary_path = function(name)
  local handle = io.popen("which " .. name)
  if handle then
    local result = handle:read("*l")
    handle:close()
    return result
  end
  return name
end

return {
  init_options = {
    ["language_server_php_cs_fixer.enabled"] = true,
    ["language_server_php_cs_fixer.bin"] = get_binary_path "php-cs-fixer",
    ["language_server_php_cs_fixer.config"] = ".php-cs-fixer.dist.php",
    ["code_transform.import_globals"] = true,
    ["navigator.destinations"] = "{dirname}/{basename}",
    ["language_server_worse_reflection.diagnostics.enable"] = false,
    ["language_server.diagnostic_ignore_codes"] = {
      "worse.undefined_variable",
    },
  },
}
