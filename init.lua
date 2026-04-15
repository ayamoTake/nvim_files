vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.api.nvim_create_autocmd("FocusGained", {
    callback = function()
        vim.opt.mouse = "nvi"
    end,
})

vim.api.nvim_create_autocmd("FocusLost", {
    callback = function()
        vim.opt.mouse = ""
    end,
})

if vim.fn.has("wsl") == 1 then
    if vim.fn.executable("xsel") == 0 then
        print("xsel not found, clipboard integration won't work")
    else
        vim.g.clipboard = {
            name = 'xsel-clipboard (wsl)',
            copy = {
                ['+'] = 'xsel -bi',
                ['*'] = 'xsel -bi',
            },
            paste = {
                ['+'] = 'xsel -bo',
                ['*'] = function() return vim.fn.systemlist('xsel -bo | tr -d "\r"') end,
            },
            cache_enabled = true,
        }
    end
end
vim.opt.clipboard = "unnamedplus"

-- LSPサーバアタッチ時の処理
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ctx)
    local set = vim.keymap.set
    set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { buffer = true })
    set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { buffer = true })
    set("n", "gK", "<cmd>lua vim.lsp.buf.hover()<CR>", { buffer = true })
    -- set("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { buffer = true })    
    set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", { buffer = true })
    set("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", { buffer = true })
    set("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", { buffer = true })
    -- set("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", { buffer = true })
    set("n", "<space>xf", "<cmd>lua vim.diagnostic.open_float()<CR>", { buffer = true })
  end,
})

vim.diagnostic.config({
  underline = true,
  signs = false,
})

-- vim.api.nvim_set_keymap('n', '<leader>r', ':w<CR>:belowright split term://g++ % -o %:r && ./%:r<CR>', { noremap = true, silent = true })

-- vim.opt.cursorline = true
-- vim.opt.cursorcolumn = true

-- 検索
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true

-- タブ
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
vim.opt.smartindent = true




-- 矩形選択
vim.opt.virtualedit="block"

-- 候補のマッチ
vim.opt.wildmenu = true
vim.opt.wildmode = "longest", "full"

-- クリップボードにヤンク
-- vim.opt.clipboard:append({ unnamedplus = true })

vim.cmd('let &t_SI .= "\\e[6 q"')
vim.cmd('let &t_EI .= "\\e[2 q"')
vim.cmd('let &t_SR .= "\\e[4 q"')

vim.opt.showmatch = true
vim.opt.splitbelow = true
vim.opt.undofile = true

vim.cmd([[
    " https://qiita.com/yahihi/items/4112ab38b2cc80c91b16
    if line("'\"") > 0 && line("'\"") <= line("$") |
      \ exe "normal g`\"" | endif
    " end https://qiita.com/yahihi/items/4112ab38b2cc80c91b16
]])

-- status line
vim.opt.laststatus = 2

if vim.fn.winwidth(0) >= 130 then
    vim.opt.statusline = "%F"
else
    vim.opt.statusline = "%t"
end

vim.opt.statusline:append(" %y%=[%l/%L]")

require("lazy").setup({
    defaults = { lazy = false, },
    spec = {
        { import = "plugins" },
        { import = "flash/flash" },
        { import = "pomo/pomo" },
    },
})

require("mapping")

-- 透明化 
vim.cmd([[
  highlight Normal       ctermbg=none guibg=none
  highlight NormalFloat  ctermbg=none guibg=none
  highlight NormalNC     ctermbg=none guibg=none
  highlight NormalSB     ctermbg=none guibg=none
  highlight NonText      ctermbg=none guibg=none
  highlight LineNr       ctermbg=none guibg=none
  highlight LineNrAbove  ctermbg=none guibg=none
  highlight LineNrBelow  ctermbg=none guibg=none
  highlight SignColumn   ctermbg=none guibg=none
  highlight CursorLine   cterm=underline gui=underline guibg=none
  highlight CursorLineNr ctermbg=none guibg=none
  highlight link CursorLineNr LineNr
]])

-- 、や。でWORD ジャンプをする.
require("ja_move")

-- ノーマルモードでのカーソル移動時に画面中央に揃える
vim.api.nvim_create_autocmd({ "CursorMoved" }, {
  callback = function ()
    local ft = vim.bo.filetype
    if ft == "TelescopePrompt" or ft == "TelescopeResults" then
      return
    end
    vim.cmd("normal! zz")
  end,
})

vim.cmd([[
  hi DiagnosticUnderlineError guifg=Red gui=underline guisp=Red
  hi DiagnosticUnderlineInfo  gui=underline guifg=Blue   guisp=Blue
  hi DiagnosticUnderlineWarn  gui=underline guifg=Yellow guisp=Yellow
  hi DiagnosticUnderlineHint  gui=underline guifg=Grey   guisp=Grey
]])

-- url を windows 側のデフォルトブラウザで開く
if vim.fn.has("wsl") == 1 then

  vim.g.netrw_browsex_viewer = "wslview"

  local orig_ui_open = vim.ui.open
  vim.ui.open = function(target)
    if type(target) == "string" and target:match("^https?://") then
      vim.fn.jobstart({ "wslview", target }, { detach = true })
    else
      orig_ui_open(target)
    end
  end
end

vim.keymap.set("i", "<CR>", function()
  vim.schedule(function()
    -- まだバッファが有効なら実行
    if vim.api.nvim_get_current_buf() ~= 0 then
      vim.cmd("normal! zz")
    end
  end)
  return "<CR>"
end, {
  expr = true,
  noremap = false,
})

vim.filetype.add({
  extension = {
    ws = "ws",
  },
})

require("myxxd")
