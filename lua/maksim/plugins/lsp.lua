return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "mason-org/mason.nvim",
        dependencies = {
          {
            "RubixDev/mason-update-all",
          },
        },
      },
      {
        "folke/neoconf.nvim",
      },
      { "mason-org/mason-lspconfig.nvim" },
      {
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "saadparwaiz1/cmp_luasnip",
        "L3MON4D3/LuaSnip",
        "rafamadriz/friendly-snippets",
      },
      {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
      {
        "onsails/lspkind.nvim",
      },
      {
        "b0o/schemastore.nvim",
      },
    },
    config = function()
      require("mason-update-all").setup({
        show_no_updates_notification = true,
      })

      require("luasnip.loaders.from_vscode").lazy_load()

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      capabilities.textDocument.completion.completionItem.snippetSupport = true

      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }

      require("lazydev").setup()

      require("neoconf").setup()

      require("mason").setup()

      require("mason-lspconfig").setup({
        automatic_enable = true,
        ensure_installed = {
          "lua_ls",
          "ruff",
          "taplo",
          "cssls",
          "css_variables",
          "tailwindcss",
          "html",
          "dockerls",
          "docker_compose_language_service",
          "pylsp",
          "jsonls",
          "yamlls",
          "ts_ls",
          "marksman",
          "emmet_ls",
          "bashls",
          "ruby_lsp",
          "fish_lsp",
        },
      })

      vim.lsp.config("bashls", {
        capabilities = capabilities,
      })

      vim.lsp.config("ruby_lsp", {
        capabilities = capabilities,
      })

      vim.lsp.config("fish_lsp", {
        capabilities = capabilities,
      })

      vim.lsp.enable("ruff")

      vim.lsp.config("html", {
        capabilities = capabilities,
      })

      vim.lsp.config("cssls", {
        capabilities = capabilities,
        settings = {
          css = {
            validate = true,
            lint = {
              unknownAtRules = "ignore",
            },
          },
        },
      })

      vim.lsp.config("css_variables", { capabilities = capabilities })

      vim.lsp.config("taplo", { capabilities = capabilities })

      vim.lsp.config("jsonls", {
        capabilities = capabilities,
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
            format = {
              enable = true,
            },
          },
        },
      })

      vim.lsp.config("yamlls", {
        capabilities = capabilities,
        settings = {
          yaml = {
            schemaStore = {
              enable = false,
              url = "",
            },
            schemas = require("schemastore").yaml.schemas(),
          },
        },
      })

      vim.lsp.config("biome", {
        root_markers = { "biome.json", "biome.jsonc" },
      })

      vim.lsp.config("ts_ls", {
        single_file_support = false,
        capabilities = capabilities,
        filetypes = {
          "typescript",
          "javascript",
          "javascriptreact",
          "typescriptreact",
        },
        root_markers = { "tsconfig.json", "jsconfig.json" },
      })

      vim.lsp.config("pylsp", {
        capabilities = capabilities,
        settings = {
          pylsp = {
            plugins = {
              pycodestyle = {
                enabled = false,
              },
              autopep8 = {
                enabled = false,
              },
              mccabe = {
                enabled = false,
              },
              pydocstyle = {
                enabled = false,
              },
              pyflakes = {
                enabled = false,
              },
            },
          },
        },
      })

      vim.lsp.config("marksman", { capabilities = capabilities })

      vim.lsp.config("emmet_language_server", {
        capabilities = capabilities,
      })

      vim.lsp.config("dockerls", { capabilities = capabilities })

      vim.lsp.config("docker_compose_language_service", {
        capabilities = capabilities,
      })

      vim.lsp.config("cssmodules_ls", {
        capabilities = capabilities,
        filetypes = { "typescriptreact", "javascriptreact" },
      })

      vim.lsp.config("tailwindcss", {
        capabilities = capabilities,
        filetypes = {
          "typescriptreact",
          "javascriptreact",
          "html",
          "css",
        },
      })

      require("ufo").setup()

      local luasnip = require("luasnip")

      local cmp = require("cmp")
      local lspkind = require("lspkind")

      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          {
            name = "cmdline",
            option = {
              ignore_cmds = { "Man", "!" },
            },
          },
        }),
      })

      cmp.setup({
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text",
            show_labelDetails = true,
          }),
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
          ["<C-d>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = {
          {
            name = "lazydev",
            group_index = 0,
          },
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        },
      })
    end,
  },
}
