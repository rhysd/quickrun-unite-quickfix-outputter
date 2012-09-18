let s:save_cpo = &cpo
set cpo&vim

let s:hook = {}
let s:hook.config = {
            \ 'enable' : 0,
            \ }

function! s:hook.on_exit(...)
    echo "hooked!"
    if exists('g:hier_enabled')
        HierUpdate
    endif
endfunction

function! quickrun#hook#hier_update#new()
    return s:hook
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
