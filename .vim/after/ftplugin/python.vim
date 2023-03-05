" au BufNewFile,BufRead *.py set
"     \ tabstop=4
"     \ softtabstop=4
"     \ shiftwidth=4
"     \ textwidth=79
"     \ expandtab
"     \ autoindent
"     \ smartindent
"     \ fileformat=unix
setlocal ts=4 sts=4 sw=4 tw=79 et ai si ff=unix
set path=.,**
setlocal wildignore=*.pyc

set include=^\\s*\\(from\\\|import\\)\\s*\\zs\\(\\S\\+\\s\\{-}\\)*\\ze\\($\\\|\ as\\)

" import conv.metrics (1)
" /conv.metrics/
" conv/metrics.py
" from conv import conversion as conv (2)
" /conv import conversion/
" conv/conversion.py conv.py
function! PyInclude(fname)
  let parts = split(a:fname, ' import ') " (1) [conv.metrics] (2) [conv, conversion]
  let l = parts[0] " (1) conv.metrics (2) conv
  if len(parts) > 1
    let r = parts[1] " conversion
    let joined = join([l, r], '.') "conv.conversion
    let fp = substitute(joined, '\.', '/', 'g') . '.py'
    echom fp
    let found = glob(fp, 1)
    if len(found)
      return found
    endif
  endif
  return substitute(l, '\.', '/', 'g') . '.py'
endfunction
setlocal includeexpr=PyInclude(v:fname)
setlocal define=^\\s*\\<\\(def\\\|class\\)\\>

"highlighting trailing whitespace and overlength lines
highlight WhitespaceEOL ctermbg=red guibg=red
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
augroup custom_highlighting
  autocmd!
  autocmd BufNewFile,BufRead,VimEnter,WinEnter *.py match WhitespaceEOL /\s\+$/ | 2match OverLength /\%80v.\+/
augroup END

imap false False
