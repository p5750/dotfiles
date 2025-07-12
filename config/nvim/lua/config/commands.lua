-- copy path
vim.api.nvim_create_user_command("CpAbsPath", function ()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {
  desc = 'Copy absolute path of the current file to the clipboard'
})
vim.keymap.set('n', '<leader>cpa', '<cmd>CpAbsPath<CR>', { silent = true })

vim.api.nvim_create_user_command("CpRelPath", function ()
  local path = vim.fn.fnamemodify(vim.fn.expand("%"), ":.")
  vim.fn.setreg("+", path)
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {
  desc = 'Copy relative path of the current file to the clipboard'
})
vim.keymap.set('n', '<leader>cpr', '<cmd>CpRelPath<CR>', { silent = true })
