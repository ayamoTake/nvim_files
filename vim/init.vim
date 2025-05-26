" 行番号
" set relativenumber

" 検索
set hlsearch
set incsearch
set noignorecase

" タブ
set expandtab
set tabstop=4
set shiftwidth=4
set noautoindent
    
" 矩形選択
set virtualedit=block

" 候補のマッチ
set wildmenu
set wildmode=longest,full

" クリップボードにヤンク
set clipboard+=unnamedplus

" カーソルの形状
" if has('vim_starting')
	" insertモードで非点滅の縦棒
	let &t_SI .= "\e[6 q"
	" nomalモードで非点滅のブロック
	let &t_EI .= "\e[2 q"
	" 置換モードで非点滅の下線
	let &t_SR .= "\e[4 q"
" endif

set showmatch

" ターミナル
set splitbelow

" 括弧の強調を打ち消す
" let loaded_matchparen = 1

set undofile
" if !isdirectory(expand("$HOME/.vim/undodir"))
"     call mkdir(expand("$HOME/.vim/undodir"), "p")
" endif
" set undodir=$HOME/.vim/undodir

" IME
" " IMEの状態を保持するための変数
" let s:last_iminsert = 0
" 
" " 挿入モードから抜けたときにIMEの状態を管理
 " autocmd InsertLeave * if v:insertmode !=# 'r' | let s:last_iminsert = &iminsert | set iminsert=0 | endif
" 
" " 挿入モードに入ったときにIMEの状態を復元
 " autocmd InsertEnter * if v:insertmode ==# 'i' | let &iminsert = s:last_iminsert | endif
"

tnoremap <Leader>q :quit!<CR>

" https://qiita.com/yahihi/items/4112ab38b2cc80c91b16
if line("'\"") > 0 && line("'\"") <= line("$") |
  \ exe "normal g`\"" | endif
" end https://qiita.com/yahihi/items/4112ab38b2cc80c91b16
