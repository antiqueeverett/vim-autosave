if exists('g:loaded_autosave') | finish | endif
let g:loaded_autosave = 1

""
" IsModifiable:
"     Checks if current buffer is modifiable.
function! IsModifiable()
    if &modifiable!=#'1' || &buftype!=#'' || &filetype ==#''
        return v:false
    elseif &modifiable==#'1' && &buftype==#'' && &filetype !=#''
        return v:true
    endif
endfunction

""
" IsNERDTree:
"     Checks if current buffer is a NERDTREE buffer.
function! IsNERDTree()
    if &modifiable==#'0' &&  &filetype ==#'nerdtree'
        return v:true
    else
        return v:false
    endif
endfunction

""
" IsNoName:
"   Checks if current buffer is a No name buffer.
function! IsNoName()
    if &buftype==#'' && bufname('%')==#'' && &modifiable==#'1'
        return v:true
    else
        return v:false
    endif
endfunction

""
" IsWorkingBuffer:
"   Checks if current buffer is a working buffer.
function! IsWorkingBuffer()
    if IsModifiable() && !IsNERDTree()
        if !IsNoName()
            return v:true
        endif
    else
        return v:false
    endif
endfunction

""
" AutoUpdate:
"   Persistently auto updates all work buffers.
"   A work buffer is any buffer with a
"   corresponding file on disk.
function! AutoUpdate()
    if IsWorkingBuffer()
        execute 'write'
    endif
endfunction

augroup auto_save
    autocmd!
    autocmd InsertLeave,
                \CursorHold,CursorMoved,
                \FocusGained,FocusLost,
                \BufWinLeave,BufLeave,
                \VimLeavePre
                \ * silent execute 'call AutoUpdate()'
augroup END
