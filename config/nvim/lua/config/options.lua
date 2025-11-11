vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.api.nvim_command('filetype plugin indent on')

vim.opt.encoding = 'utf-8'
vim.opt.number = true
vim.opt.ruler = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.signcolumn = 'yes'
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.clipboard = 'unnamedplus,unnamed'
vim.opt.termguicolors = true
vim.opt.winblend = 0
vim.opt.pumblend = 0
vim.opt.autoread = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.showmatch = true
vim.opt.list = true
vim.opt.listchars = 'tab:▸-,trail:-,extends:»,precedes:«,nbsp:%'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.gdefault = true
vim.opt.wrapscan = true
vim.opt.hlsearch = true
vim.opt.hidden = true
vim.opt.showcmd = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.undofile = true
vim.opt.updatetime = 300
vim.opt.pumblend = 15
vim.opt.numberwidth = 5
vim.opt.colorcolumn = '80'
vim.opt.cursorline = true

-- Key mappings
vim.keymap.set('i', 'jj', '<ESC>', { silent = true })
vim.keymap.set('n', 'tt', '<cmd>terminal<CR>', { silent = true })
vim.keymap.set('n', 'tx', '<cmd>belowright new<CR><cmd>terminal<CR>', { silent = true })
vim.keymap.set('n', '<leader>hd', '<cmd>DiffviewOpen HEAD~1<CR>', { silent = true })
vim.keymap.set('n', '<leader>hf', '<cmd>DiffviewFileHistory %<CR>', { silent = true })
vim.keymap.set('n', '<leader>bl', '<cmd>GitBlameToggle<CR>')
vim.keymap.set('n', 'grd', '<cmd>:lua vim.lsp.buf.definition()<CR>', { silent = true })

-- Autocommands
vim.api.nvim_create_autocmd('TermOpen', {
  pattern = '*',
  command = 'startinsert'
})
vim.api.nvim_create_autocmd({ "FileType" }, {
  callback = function()
    local ft = vim.bo.filetype
    if ft == "lua" then
      vim.opt_local.foldmethod = "expr"
      vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"
    elseif ft == "ruby" then
      vim.opt_local.foldmethod = "indent"
    else
      vim.opt_local.foldmethod = "manual"
    end
  end,
})
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.slim" },
  command = "set ft=slim",
})
