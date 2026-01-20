" sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
" Error detected while processing /jugyou/ise/23D8101003K/.config/nvim/init.vim:
" line  325:
" E5108: Error executing lua [string ":lua"]:45: attempt to call field 'setup_handlers' (a nil value)
" stack traceback:
"         [string ":lua"]:45: in main chunk
" :MasonUpdate


call plug#begin()
        Plug 'easymotion/vim-easymotion'
        Plug 'edvb/catium.vim'

        " color scheme
        Plug 'Mofiqul/vscode.nvim'

        " comment
        Plug 'numToStr/Comment.nvim'

        " tree
        Plug 'nvim-tree/nvim-tree.lua'

        " scroll bar
        
        " indent line
        Plug 'lukas-reineke/indent-blankline.nvim'

        " term 
        Plug 'akinsho/toggleterm.nvim'
        
        " flatten windows opened by term
        Plug 'willothy/flatten.nvim'

        " substitution
        Plug 'https://github.com/tpope/vim-abolish.git'

        "screenshot 
        Plug 'segeljakt/vim-silicon'
        
        " for lean
        Plug 'Julian/lean.nvim'
        Plug 'nvim-lua/plenary.nvim'

        " LSP
        Plug 'neovim/nvim-lspconfig'
        Plug 'williamboman/mason.nvim'
        Plug 'williamboman/mason-lspconfig.nvim'

        " Optional Dependencies

        Plug 'hrsh7th/nvim-cmp'        " For LSP completion
        Plug 'hrsh7th/cmp-nvim-lsp'
        Plug 'hrsh7th/cmp-buffer'
        Plug 'hrsh7th/cmp-path'
        Plug 'hrsh7th/cmp-cmdline'

        Plug 'hrsh7th/vim-vsnip'       " For snippets
        Plug 'hrsh7th/vim-vsnip-integ'
        Plug 'hrsh7th/cmp-vsnip'

        Plug 'andrewradev/switch.vim'  " For Lean switch support
        Plug 'tomtom/tcomment_vim'     " For commenting motions
        Plug 'nvim-telescope/telescope.nvim' " For Loogle search

        " for markdown
        Plug 'kannokanno/previm'
        Plug 'godlygeek/tabular'
        Plug 'preservim/vim-markdown'
        Plug 'tyru/open-browser.vim'

        " for typst
        Plug 'kaarmu/typst.vim'

        Plug 'cohama/lexima.vim'
call plug#end()

let s:plugs=get(s:,'plugs',get(g:,'plugs',{}))
function! FindPlugin(name) abort
        return has_key(s:plugs,a:name) ? isdirectory(s:plugs[a:name].dir ):0
endfunction

command! -nargs=1 UsePlugin if !FindPlugin(<args>) | finish | endif

let g:config_nvim_vim_dir = expand('~/.config/nvim/vim')
for file in split(globpath(g:config_nvim_vim_dir, '*.vim'), "\n")
        execute 'source' . file
endfor

lua require("toggleterm").setup()
nnoremap <silent><leader>t <Cmd>exe v:count1 . "ToggleTerm"<CR>
" nnoremap <silent><leader>t <Cmd>lua require("toggleterm.terminal").Terminal:new():toggle()<CR>

" set cursorline
" set cursorcolumn

let g:silicon = {
        \ 'theme':              'Visual Studio Dark+',
        \ 'font':               'Hack; IPAGothic',
        \ 'window-controls':    v:false,
	\ 'line-number':        v:false,
        \ 'round-corner':       v:false,
        \ 'pad-horiz':          0,
        \ 'pad-vert':           0,
\}

let g:direname = '~/Image/screenshots/codes/'
let g:filename = '{file:%:t:r}'
let g:datetime = '{time:%Y-%m-%d-%H-%M-%S}'
let g:silicon['output'] = direname . filename . '-' . datetime . '.png'

autocmd FocusGained * set mouse=nvi
autocmd FocusLost * set mouse=

" for markdown vim
let g:vim_markdown_folding_disabled = 1
let g:previm_open_cmd='firefox'

" for typst
" let g:typst_pdf_viewer=''
" let g:typst_conceal=1
" let g:typst_conceal_emoji=1
let g:typst_embedded_languages=['c', 'cpp', 'python', 'rust']

" カーソルが閉じ括弧の上にいるとき、自動でスキップする
let g:lexima_enable_basic_rules = 1

" 改行時に自動インデント（中括弧などに便利）
let g:lexima_enable_newline_rules = 1

let g:vsnip_snippet_dir = expand('$HOME/.config/nvim/plugin/vsnip')

lua << END

vim.g.maplocalleader = ' '

vim.cmd.colorscheme "vscode"

-- for comment.nvim 
require('Comment').setup()

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


-- require("ibl").setup()

require("flatten").setup({open = "alternate",})

-- 透明化 
vim.cmd([[
  highlight Normal guibg=none
  highlight NonText guibg=none
  highlight Normal ctermbg=none
  highlight NonText ctermbg=none
  highlight NormalNC guibg=none
  highlight NormalSB guibg=none
]])

-- require("mason").setup()
-- require("mason-lspconfig").setup()
-- require("mason-lspconfig").setup_handlers {
--   function(server_name)
--     require("lspconfig")[server_name].setup {}
--   end,
-- }

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
    set("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", { buffer = true })
    set("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", { buffer = true })

  end,
})
