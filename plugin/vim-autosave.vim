if exists('g:loaded_autosave') | finish | endif
let g:loaded_autosave = 1

""
" Writable:
"     Checks if current buffer is writable.
function! Writable()
    if &modifiable==#'1' && &buftype==#'' && &filetype !=#''
        return v:true
    elseif &modifiable!=#'1' || &buftype!=#'' || &filetype ==#''
        return v:false
    endif
endfunction

""
" IsNERDTree:
"     Checks if current buffer is a NERDTREE buffer.
function! IsNERDTree()
    if  &filetype ==#'nerdtree'
        return v:true
    else
        return v:false
    endif
endfunction

""
" IsNoName:
"   Checks if current buffer is a No Name buffer.
function! IsNoName()
    if &buftype==#'' && bufname('%')==#'' && &modifiable==#'1'
        return v:true
    else
        return v:false
    endif
endfunction

""
" Savable:
"   Checks if current buffer is a working buffer.
function! Savable()
    if Writable() && !IsNERDTree()
        if !IsNoName()
            return v:true
        endif
    else
        return v:false
    endif
endfunction

""
" AutoSave:
"   Persist :write
function! AutoSave()
    if Savable()
        execute 'write'
    endif
endfunction

" VIM_AUTOSAVE CASES:
"   case 1: leaving insert mode [ InsertLeave ]
"   case 2: before leaving a buffer [ BufLeave ]
"   case 3: before deleting a buffer [ BufDelete ]
"   case 4: before exiting vim [ VimLeavePre ]
"   case 5: after text is change [ TextChanged, TextChangedI, TextChangedP ]
augroup vim_autosave_au
    autocmd!
    autocmd InsertLeave,BufLeave,VimLeavePre * :call AutoSave()
    autocmd TextChanged,TextChangedI,TextChangedP * :call AutoSave()
augroup END
