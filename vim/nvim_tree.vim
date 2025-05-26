function! TreeOpenCurFile() 
	let l:curdir = expand('%:h')
	execute 'NvimTreeOpen ' . l:curdir
endfunction

nnoremap <silent><Leader>e :call TreeOpenCurFile()<CR>

lua << EOF
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

local function my_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.del('n', '<CR>', { buffer = bufnr })
  vim.keymap.set('n', '<CR>',   api.node.open.vertical,              opts('Open: Vertical Split'))
  vim.keymap.del('n', '<Tab>', { buffer = bufnr })
  vim.keymap.set('n', '<Tab>',   api.node.open.tab,                   opts('Open: New Tab'))
  vim.keymap.set('n', '?',     api.tree.toggle_help,                  opts('Help'))
  vim.keymap.del('n', 'u', { buffer = bufnr })
  vim.keymap.set('n', 'u',       api.tree.change_root_to_parent,      opts('Up'))
  vim.keymap.set('n', 'cd',   api.tree.change_root_to_node,        opts('CD'))
end

-- pass to setup along with your other options
require("nvim-tree").setup {
  filters = {
    dotfiles = true,
  },
  on_attach = my_on_attach,
  actions = {
    open_file = {
      window_picker = {
        -- enable = false,
        enable = true,
      },
    },
  },
}

EOF
