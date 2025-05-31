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

vim.cmd([[

let s:plugs=get(s:,'plugs',get(g:,'plugs',{}))
function! FindPlugin(name) abort
        return has_key(s:plugs,a:name) ? isdirectory(s:plugs[a:name].dir ):0
endfunction

command! -nargs=1 UsePlugin if !FindPlugin(<args>) | finish | endif

let g:config_nvim_vim_dir = expand('~/.config/nvim/vim')
for file in split(globpath(g:config_nvim_vim_dir, '*.vim'), "\n")
        execute 'source' . file
endfor

" set cursorline
" set cursorcolumn

autocmd FocusGained * set mouse=nvi
autocmd FocusLost * set mouse=

]])

require("lazy").setup({
    defaults = { lazy = false, },
    spec = {
        { import = "plugins" },
    },
})

require("mapping")

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



-- 透明化 
vim.cmd([[
  highlight Normal guibg=none
  highlight NonText guibg=none
  highlight Normal ctermbg=none
  highlight NonText ctermbg=none
  highlight NormalNC guibg=none
  highlight NormalSB guibg=none
]])

-- LSPサーバアタッチ時の処理
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ctx)
    local set = vim.keymap.set
    set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { buffer = true })
    set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { buffer = true })
    set("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { buffer = true })    
    set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", { buffer = true })
    set("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", { buffer = true })
    set("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", { buffer = true })
    set("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", { buffer = true })

  end,
})

-- vim.api.nvim_set_keymap('n', '<leader>r', ':w<CR>:belowright split term://g++ % -o %:r && ./%:r<CR>', { noremap = true, silent = true })

