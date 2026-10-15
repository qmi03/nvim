return {
  capabilities = {
    textDocument = { semanticTokens = { multilineTokenSupport = true } },
  },
  filetypes = {
    "asciidoc",
    "html",
    "toml",
    "cmake",
    "sh",
    "markdown",
    "mdx",
    "text",
    "tex",
    "typst",
  },
  root_markers = { ".harper-dictionary.txt", ".git" },
  cmd = { "harper-ls", "--stdio" },
  settings = {
    ["harper-ls"] = {
      userDictPath = "",
      workspaceDictPath = "",
      fileDictPath = "",
      linters = {
        SpellCheck = true,
        SpelledNumbers = false,
        AnA = true,
        SentenceCapitalization = true,
        UnclosedQuotes = true,
        WrongApostrophe = false,
        LongSentences = true,
        RepeatedWords = true,
        Spaces = true,
        CorrectNumberSuffix = true,
      },
      codeActions = {
        ForceStable = false,
      },
      markdown = {
        IgnoreLinkTitle = false,
      },
      diagnosticSeverity = "hint",
      isolateEnglish = false,
      dialect = "American",
      maxFileLength = 120000,
      ignoredLintsPath = "",

      excludePatterns = {},
    },
  },
}
