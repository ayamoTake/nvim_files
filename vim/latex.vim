function! CompileTex()
    :w
    " %:p は現在のバッファのファイル名（フルパス）を表す
    let filename = expand('%')  

    " let command = 'lualatex ' . shellescape(filename) 
    let command = 'lualatex ' . filename
    " echo filename
    " echo shellescape(filename)

    execute "bo term " . command . ' && exit'
endfunction

function! Insertalign()
    execute "normal! o\\begin{align*}" . "\<CR>" . "\\end{align*}"
    normal! k
endfunction

autocmd FileType tex nnoremap <buffer> <C-u> :call CompileTex()<CR>
autocmd FileType tex setlocal shiftwidth=2
autocmd FileType tex setlocal expandtab
autocmd FileType tex setlocal tabstop=2
autocmd FileType tex nnoremap <buffer><Leader>a :call Insertalign()<CR>
autocmd FileType tex inoremap $ $$<ESC>i
