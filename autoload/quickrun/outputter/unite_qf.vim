" Author : rhysd <lin90162@yahoo.co.jp>
" License: MIT License http://www.opensource.org/licenses/mit-license.php

let s:save_cpo = &cpo
set cpo&vim

if !exists('g:quickrun_unite_qf_outputter_args')
    let g:quickrun_unite_qf_outputter_args = []
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
    call unite#start( extend(['qf'], g:quickrun_unite_qf_outputter_args) )
  finally
    let &l:errorformat = errorformat
  endtry

  " update Hier highlight
  if exists('g:hier_enabled')
      :HierUpdate
  endif
endfunction

function! quickrun#outputter#unite_qf#new()
  return deepcopy(s:outputter)
endfunction

let &cpo = s:save_cpo
