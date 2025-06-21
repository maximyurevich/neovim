return {
  {
    "RRethy/nvim-treesitter-endwise",
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependecies = { "nvim-treesitter/nvim-treesitter" },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup({
        enable = true,
        multiwindow = false,
        max_lines = 0,
        min_window_height = 0,
        line_numbers = true,
        multiline_threshold = 20,
        trim_scope = "outer",
        mode = "cursor",
        separator = nil,
        zindex = 20,
        on_attach = nil,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter.configs")
      configs.setup({
        ensure_installed = {
          "regex",
          "lua",
          "gitignore",
          "json",
          "toml",
          "yaml",
          "python",
          "javascript",
          "typescript",
          "tsx",
        },
        indent = {
          enable = true,
        },
        highlight = {
          enable = true,
        },
        endwise = {
          enable = true,
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["as"] = "@block.outer",
              ["is"] = "@block.inner",
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ["<space>p"] = "@parameter.inner",
              ["<space>b"] = "@block.outer",
              ["<space>a"] = "@class.outer",
              ["<space>M"] = "@function.outer",
            },
            swap_previous = {
              ["<space>P"] = "@parameter.inner",
              ["<space>B"] = "@block.outer",
              ["<space>A"] = "@class.outer",
              ["<space>m"] = "@function.outer",
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]m"] = "@function.outer",
              ["]]"] = "@class.outer",
            },
            goto_next_end = {
              ["]M"] = "@function.outer",
              ["]["] = "@class.outer",
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
              ["[["] = "@class.outer",
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
              ["[]"] = "@class.outer",
            },
          },
          lsp_interop = {
            enable = true,
            border = "none",
            floating_preview_opts = {},
            peek_definition_code = {
              ["<space>df"] = "@function.outer",
              ["<space>dF"] = "@class.outer",
            },
          },
        },
      })
    end,
  },
}
