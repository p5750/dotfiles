return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
      "lukas-reineke/lsp-format.nvim",
    },
    config = function()
      require('lsp-format').setup()
      require('mason').setup()

      local ensure_installed = {
        'lua_ls',
        'rust_analyzer',
        'clangd',
        'zls',
        'ts_ls',
        'phpactor',
        'bashls',
      }
      require('mason-lspconfig').setup {
        automatic_installation = true,
        ensure_installed = ensure_installed,
      }
      vim.lsp.config('*', {
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
      })
      vim.lsp.enable(ensure_installed)

      -- ruby_lsp, rubocop depends on rbenv, so is not managed by mason
      vim.lsp.enable({ 'ruby_lsp', 'rubocop' })

      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        update_in_insert = false,
        float = {
          source = "always",
        },
      })

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          vim.api.nvim_buf_set_keymap(ev.buf, 'n', '<leader>li', '<cmd>LspInfo<CR>',
            { noremap = true, silent = true, desc = 'LSP Info' })
        end,
      })

      -- Helper function to remove duplicate LSP results
      local function remove_duplicates(result)
        if result == nil or vim.tbl_isempty(result) then
          return {}
        end

        local seen = {}
        local unique_results = {}
        for _, item in ipairs(result) do
          local key = item.uri .. ':' .. item.range.start.line .. ':' .. item.range.start.character
          if not seen[key] then
            seen[key] = true
            table.insert(unique_results, item)
          end
        end

        return unique_results
      end

      -- LSP handlers to remove duplicates
      vim.lsp.handlers['textDocument/references'] = function(_, result, ctx, config)
        local unique_results = remove_duplicates(result)
        if vim.tbl_isempty(unique_results) then
          return
        end

        vim.lsp.util.locations_to_items(unique_results, vim.lsp.get_client_by_id(ctx.client_id).offset_encoding)
        vim.fn.setqflist({}, ' ', {
          title = 'LSP References',
          items = vim.lsp.util.locations_to_items(unique_results, vim.lsp.get_client_by_id(ctx.client_id).offset_encoding)
        })
        vim.cmd('copen')
      end

      vim.lsp.handlers['textDocument/definition'] = function(_, result, ctx, config)
        local unique_results = remove_duplicates(result)
        if vim.tbl_isempty(unique_results) then
          return
        end

        if #unique_results == 1 then
          vim.lsp.util.jump_to_location(unique_results[1], vim.lsp.get_client_by_id(ctx.client_id).offset_encoding)
        else
          vim.lsp.util.locations_to_items(unique_results, vim.lsp.get_client_by_id(ctx.client_id).offset_encoding)
          vim.fn.setqflist({}, ' ', {
            title = 'LSP Definitions',
            items = vim.lsp.util.locations_to_items(unique_results, vim.lsp.get_client_by_id(ctx.client_id).offset_encoding)
          })
          vim.cmd('copen')
        end
      end
    end,
  },
}
