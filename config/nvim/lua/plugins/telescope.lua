return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local telescope_builtin = require('telescope.builtin')
      vim.keymap.set('n', '<C-p>', function()
        telescope_builtin.find_files({ hidden = true })
      end, {})
      vim.keymap.set('n', '<leader>s', telescope_builtin.live_grep, {})
      vim.keymap.set('n', '<leader>;', telescope_builtin.buffers, {})

      local actions = require('telescope.actions')
      local my_mappings = {
        ['<C-j>'] = {
          actions.move_selection_next,
          type = 'action',
          opts = { nowait = true, silent = true },
        },
        ['<C-k>'] = {
          actions.move_selection_previous,
          type = 'action',
          opts = { nowait = true, silent = true },
        },
        ['<C-[>'] = {
          actions.close,
          type = 'action',
          opts = { nowait = true, silent = true },
        },
      }

      require('telescope').setup {
        defaults = {
          layout_strategy = 'vertical',
          mappings = {
            i = my_mappings,
            n = my_mappings,
          },
        },
      }
    end,
  },
}
