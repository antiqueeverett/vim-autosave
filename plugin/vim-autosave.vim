if exists('g:loaded_autosave') | finish | endif
let g:loaded_autosave = 1

" callable greet command
command AUTOSAVE call s:autosave()

function! s:autosave() abort
    echom 'autsave up and running!'
endfunction
