return {
  on_attach = function(client, bufnr)
    if client.server_capabilities.semanticTokensProvider then
      vim.lsp.semantic_tokens.start(bufnr, client.id)
    end
  end,
  preferences = {
    quotePreference = 'single',
    organizeImportsCollation = 'ordinal',
    organizeImportsCollationLocale = 'en',
    includePackageJsonAutoImports = 'on',
    importModuleSpecifierPreference = 'relative',
    includeAutomaticOptionalChainCompletions = true,
    includeCompletionsWithInsertText = true,
  },
  format = {
    indentSize = 4,
    tabSize = 4,
    convertTabsToSpaces = true,
    insertSpaceAfterCommaDelimiter = true,
    insertSpaceAfterConstructor = false,
    insertSpaceAfterSemicolonInForStatements = true,
    insertSpaceBeforeAndAfterBinaryOperators = true,
    insertSpaceAfterKeywordsInControlFlowStatements = true,
    insertSpaceAfterOpeningAndBeforeClosingNonemptyBraces = false,
    insertSpaceAfterFunctionKeywordForAnonymousFunctions = false,
    placeOpenBraceOnNewLineForControlBlocks = true,
    placeOpenBraceOnNewLineForFunctions = true,
  },

}
