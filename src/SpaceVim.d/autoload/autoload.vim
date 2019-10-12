function! autoload#after() abort
  let g:indentLine_enabled = 0
  set autoread
  au CursorHold,CursorHoldI * checktime
endfunction
