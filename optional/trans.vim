
" https://qiita.com/yahihi/items/4112ab38b2cc80c91b16
if line("'\"") > 0 && line("'\"") <= line("$") |
  \ exe "normal g`\"" | endif
" end https://qiita.com/yahihi/items/4112ab38b2cc80c91b16

function! CopyToRightWindow()
	normal! gv
	normal! y

	wincmd w
	normal! Go

	normal! p

	execute ":.! trans -b en:ja"

	normal! ^
	normal! P
	normal! a:

	wincmd w
endfunction

xnoremap <C-t> :call CopyToRightWindow()<CR>
