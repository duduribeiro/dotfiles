return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local navic = require("nvim-navic")
      local on_attach = function(client, bufnr)
        if client.server_capabilities.documentSymbolProvider then
          navic.attach(client, bufnr)
        end
      end

      local lspconfig = require("lspconfig")
      lspconfig.tsserver.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })
      lspconfig.solargraph.setup({
        capabilities = capabilities,
        -- on_attach = on_attach,
      })
      lspconfig.html.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      lspconfig.ruby_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        on_init = function(client, _)
          -- disable semanticTokensProvider if LSP is getting weird color on colorscheme
          --
          client.server_capabilities.semanticTokensProvider = nil
        end,
        cmd = {
          "bundle",
          "exec",
          "ruby-lsp",
        },
      });

      --lspconfig.ruby_ls.setup({
      --  cmd = { "ruby-lsp" },
      --  on_attach = on_attach,
      --  on_init = function(client, _)
      --    -- disable semanticTokensProvider if LSP is getting weird color on colorscheme
      --    --
      --    client.server_capabilities.semanticTokensProvider = nil
      --  end,
      --  capabilities = capabilities,
      --})

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
      -- Rename the variable under your cursor
      --  Most Language Servers support renaming across files, etc.
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "[R]e[n]ame" })
    end,
  },
  -- A simple statusline/winbar component that uses LSP to show your current code context. Named after the Indian satellite navigation system.
  {
    "SmiteshP/nvim-navic",
    config = function()
      require("nvim-navic").setup({
        lsp = {
          auto_attach = false,
        },
        separator = " 󰁔 ",
      })

      vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"

    end,
    dependencies = {
      "neovim/nvim-lspconfig",
    }
  }
}
