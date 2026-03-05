return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = {
          "typescript",
          "tsx",
          "cpp",
          "yaml",
          "lua",
          "vimdoc",
          "vue",
          "json",
          "markdown",
          "terraform",
        },
        highlight = {
          enable = true,
        },
      }
    end,
  },
}
