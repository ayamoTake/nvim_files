UsePlugin 'preview-markdown.vim'
let g:preview_markdown_auto_update=1
let g:preview_markdown_vertical=1

let g:mapleader="\<Space>"
autocmd FileType markdown noremap <buffer> <Leader>p  :PreviewMarkdown tab<cr>

autocmd FileType markdown nnoremap <buffer> o zzA<CR>
