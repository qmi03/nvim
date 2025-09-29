return {
  cmd = { "clangd", "--background-index", "--clang-tidy", "--log=verbose" },
  init_options = {
    clangdFileStatus = true,
    fallbackFlags = { "-std=c++11" },
  },
  formatter = "clang-format",
}
