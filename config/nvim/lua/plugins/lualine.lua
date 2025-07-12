return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "kyazdani42/nvim-web-devicons",
      "arkav/lualine-lsp-progress"
    },
    config = function()
      require('lualine').setup {
        sections = {
          lualine_c = {
            { 'filename', path = 1 },
            'lsp_progress',
          },
        },
      }
    end,
  },
}
