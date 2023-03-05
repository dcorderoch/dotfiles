" Copy yank buffer to system clipboard
" Use OSC52 to put things into the system clipboard, works over SSH!
function! Osc52Yank()
  let buffer=system('base64 -w0', @0) " -w0 to disable 76 char line wrapping
  let buffer="\e]52;c;" . buffer . "\x07"
  exe "silent! !printf \\%s" shellescape(l:buffer) | redraw!
endfunction


augroup Yank
  if has('patch-8.0.1394')
    autocmd!
    autocmd TextYankPost * if v:event.operator ==# 'y' | call Osc52Yank() | endif
  else
    nnoremap <Leader>y :call Osc52Yank()<CR>
  endif
augroup END
