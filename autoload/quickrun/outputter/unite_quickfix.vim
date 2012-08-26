" Author : rhysd <lin90162@yahoo.co.jp>
" License: MIT License http://www.opensource.org/licenses/mit-license.php

let s:save_cpo = &cpo
set cpo&vim

if !exists('g:quickrun_unite_quickfix_outputter_args')
    let g:quickrun_unite_quickfix_outputter_args = []
endif

if !exists('g:quickrun_unite_quickfix_outputter_unite_context')
    let g:quickrun_unite_quickfix_outputter_unite_context = []
endif

let s:outputter = quickrun#outputter#buffered#new()
let s:outputter.config = {
\   'errorformat': '&errorformat',
\ }

function! s:outputter.finish(session)
  try
    let errorformat = &l:errorformat
    let &l:errorformat = self.config.errorformat
    cgetexpr self._result
     call unite#start( extend(['quickfix'], g:quickrun_unite_quickfix_outputter_args), g:quickrun_unite_quickfix_outputter_unite_context )
  finally
    let &l:errorformat = errorformat
  endtry

  " update Hier highlight
  if exists('g:hier_enabled')
      :HierUpdate
  endif
endfunction

function! quickrun#outputter#unite_quickfix#new()
  return deepcopy(s:outputter)
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
