let s:plugs=get(s:,'plugs',get(g:,'plugs',{}))
function! FindPlugin(name) abort
	return has_key(s:plugs,a:name) ? isdirectory(s:plugs[a:name].dir ):0

endfunction
inoremap uu <Esc>
noremap j jzz
noremap k kzz
noremap l l
noremap h h

noremap <C-j> gj
noremap <C-k> gk

noremap J }zz
noremap K {zz
noremap H ^
noremap L $
vnoremap L $h
noremap G Gzz

nnoremap o zzo
nnoremap O zzO

noremap { {zz
noremap } }zz

" let g:mapleader="\<Space>"
let g:mapleader="\<Space>"
nnoremap <Leader>h <c-w>h
nnoremap <Leader>j <c-w>j
nnoremap <Leader>k <c-w>k
nnoremap <Leader>l <c-w>l

" if FindPlugin('vim-lsp') 
" 	nnoremap <Leader>w :LspDocumentFormat<CR>:w<CR>
" else
" 	nnoremap <Leader>w :w<CR>
" endif
nnoremap <Leader>w :w<CR>

" レジスタに入れない
" nnoremap x "_x
nnoremap s "_s
nnoremap c "_c
" 連続ペースト
xnoremap p "_xP
nnoremap <CR> A<CR><Esc>0Dzz

" 全選択
vnoremap <Leader>a <Esc>ggVG

nnoremap mm `

" ターミナル
" nnoremap <C-j> :term ++rows=10<CR>
tnoremap uu <C-\><C-n>
tnoremap <Esc> <C-\><C-n>

" go upper / lower
nnoremap gu vgU
nnoremap gl vgu

vnoremap gu gU
vnoremap gl gu

nnoremap dp dap

" for Undo
inoremap <CR> <C-g>u<C-o>zz<CR>

" count character in curent line
vnoremap m :w !wc -m<CR>

nnoremap <leader><leader>t :tabnew \| term<CR>

" vim-vsnip
" " Insertモード中に <Tab> を押したときの動作を定義
" imap <expr> <Tab> vsnip#expandable()      ? '<Plug>(vsnip-expand)'         :
"                  \ vsnip#jumpable(1)      ? '<Plug>(vsnip-jump-next)'      :
"                  \                        '<Tab>'
"
" " Selectモードでも同様に
" smap <expr> <Tab> vsnip#expandable()      ? '<Plug>(vsnip-expand)'         :
"                  \ vsnip#jumpable(1)      ? '<Plug>(vsnip-jump-next)'      :
"                  \                        '<Tab>'
"
" " Shift-Tab で前のタブストップに戻る（これはそのままでOK）
" imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'
" smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'


command! Q q!
