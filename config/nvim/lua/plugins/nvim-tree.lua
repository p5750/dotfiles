return {
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      local function label(path)
        path = path:gsub(os.getenv 'HOME', '~', 1)
        return path:gsub('~/repos/github.com/([a-zA-Z0-9_-]+)/([a-zA-Z0-9_-]+)', " [%1/%2]")
      end
      require("nvim-tree").setup({
        sort = { sorter = "case_sensitive", },
        view = { width = 30, },
        renderer = {
          root_folder_label = label,
          group_empty = false,
          highlight_git = true,
          highlight_opened_files = 'name',
          icons = {
            glyphs = {
              git = {
                unstaged = '!', renamed = '»', untracked = '?', deleted = '✘',
                staged = '✓', unmerged = '', ignored = '◌',
              }
            }
          }
        },
        filters = {
          dotfiles = false,
          git_ignored = false,
        },
      })

      local api = require("nvim-tree.api")
      vim.api.nvim_create_autocmd("BufEnter", {
        callback = function()
          api.tree.find_file({ buf = vim.fn.bufnr() })
        end
      })
    end,
  },
}
