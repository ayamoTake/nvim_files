set laststatus=2

if winwidth(0) >= 130
	" フルパス
	set statusline=%F
else
	" ファイル名
	set statusline=%t
endif

" ファイル種別
set statusline+=\ %y

set statusline+=%=

" 現在行 / 全体行
set statusline+=[%l/%L]
