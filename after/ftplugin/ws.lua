vim.opt_local.autoindent = false
vim.opt_local.smartindent = false

vim.opt_local.expandtab = false
vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 0

vim.opt_local.copyindent = false
vim.opt_local.preserveindent = false
vim.opt_local.indentexpr = ""

local normal_fg = vim.api.nvim_get_hl(0, { name = "Normal" }).fg
vim.api.nvim_set_hl(0, "Whitespace", { fg = normal_fg })
vim.api.nvim_set_hl(0, "NonText", { fg = normal_fg })

vim.opt_local.list = true
vim.opt_local.listchars = {
  eol = "↲",
  space = "·",
  tab = "↦ ",
  nbsp = "·",
}
