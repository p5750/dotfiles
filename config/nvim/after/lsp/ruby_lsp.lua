return {
  init_options = {
    formatter = 'standard',
    linters = { 'standard' },
    addonSettings = {
      ["Ruby LSP Rails"] = {
        enablePendingMigrationsPrompt = false,
      },
    }
  },
  cmd = { vim.fn.expand("$RBENV_ROOT/shims/ruby-lsp") },
}
