if exists('g:loaded_helloworld') | finish | endif
let g:loaded_helloworld = 1

" callable greet command
command Greet call s:greet()

function! s:greet() abort
    echom 'hell everett'
endfunction
