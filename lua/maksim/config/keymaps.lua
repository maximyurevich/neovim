-- telescope

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", builtin.find_files, { silent = true })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { silent = true })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { silent = true })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { silent = true })

-- oil

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- refactoring

vim.keymap.set({ "n", "x" }, "<leader>re", function()
  return require("refactoring").refactor("Extract Function")
end, { expr = true })

vim.keymap.set({ "n", "x" }, "<leader>rf", function()
  return require("refactoring").refactor("Extract Function To File")
end, { expr = true })

vim.keymap.set({ "n", "x" }, "<leader>rv", function()
  return require("refactoring").refactor("Extract Variable")
end, { expr = true })

vim.keymap.set({ "n", "x" }, "<leader>rI", function()
  return require("refactoring").refactor("Inline Function")
end, { expr = true })

vim.keymap.set({ "n", "x" }, "<leader>ri", function()
  return require("refactoring").refactor("Inline Variable")
end, { expr = true })

vim.keymap.set({ "n", "x" }, "<leader>rbb", function()
  return require("refactoring").refactor("Extract Block")
end, { expr = true })

vim.keymap.set({ "n", "x" }, "<leader>rbf", function()
  return require("refactoring").refactor("Extract Block To File")
end, { expr = true })

-- lspsaga

vim.keymap.set("n", "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<cr>")
vim.keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<cr>")
vim.keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<cr>")
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

-- dap

vim.keymap.set("n", "<F5>", function()
  require("dap").continue()
end)

vim.keymap.set("n", "<F10>", function()
  require("dap").step_over()
end)

vim.keymap.set("n", "<F11>", function()
  require("dap").step_into()
end)

vim.keymap.set("n", "<F12>", function()
  require("dap").step_out()
end)

vim.keymap.set("n", "<Leader>b", function()
  require("dap").toggle_breakpoint()
end)

vim.keymap.set("n", "<Leader>B", function()
  require("dap").set_breakpoint()
end)

vim.keymap.set("n", "<Leader>lp", function()
  require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end)

vim.keymap.set("n", "<Leader>dr", function()
  require("dap").repl.open()
end)

vim.keymap.set("n", "<Leader>dl", function()
  require("dap").run_last()
end)
vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
  require("dap.ui.widgets").hover()
end)

vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
  require("dap.ui.widgets").preview()
end)

vim.keymap.set("n", "<Leader>df", function()
  local widgets = require("dap.ui.widgets")
  widgets.centered_float(widgets.frames)
end)

vim.keymap.set("n", "<Leader>ds", function()
  local widgets = require("dap.ui.widgets")
  widgets.centered_float(widgets.scopes)
end)

vim.keymap.set("n", "<leader>dc", function()
  require("dapui").open()
end)

vim.keymap.set("n", "<leader>dt", function()
  require("dapui").toggle()
end)

vim.keymap.set("n", "<leader>do", function()
  require("dapui").close()
end)

-- overseer

vim.keymap.set("n", "<leader>or", "<cmd>OverseerRun<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>ob", "<cmd>OverseerBuild<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>oi", "<cmd>OverseerInfo<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>oo", "<cmd>OverseerOpen<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>ot", "<cmd>OverseerToggle<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>oa", "<cmd>OverseerQuickAction<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>oC", "<cmd>OverseerClearCache<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>oA", "<cmd>OverseerTaskAction<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>os", "<cmd>OverseerSaveBundle<cr>", { noremap = true, silent = true })
vim.keymap.set(
  "n",
  "<leader>od",
  "<cmd>OverseerDeleteBundle<cr>",
  { noremap = true, silent = true }
)
vim.keymap.set("n", "<leader>ol", "<cmd>OverseerLoadBundle<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>or", "<cmd>OverseerRunCmd<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>oc", "<cmd>OverseerClose<CR>", { noremap = true, silent = true })

-- treesitter

vim.keymap.set("n", "[c", function()
  require("treesitter-context").go_to_context(vim.v.count1)
end, { silent = true })

local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
