return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        yaml = { "yamlfix" },
        toml = { "taplo" },
        python = { "ruff", "ruff_organize_import", "ruff_format" },
      },
    },
  },
}
