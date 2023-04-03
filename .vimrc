set nocompatible "don't need to keep compatibility with Vi
set secure       "disable unsafe stuff from local .vimrc files
set exrc         "enable loading directory-specific .vimrc files

" <C-R>/ pastes the last thing I searched
" CTRL+a in insert mode re-dos the last edit
" CTRL+r in insert mode lets you press . to re-do the last edit

"set noswapfile

" Search down into sub-folders
" Provides tab-completion for all file-related tasks
set path+=**
function! Preserve(command)
  let _s=@/
  let l = line(".")
  let c = col(".")
  execute "silent!" . a:command
  call cursor(l, c)
  let @/=_s
endfunction
" automatically delete trailing whitespace on save
function! TrimSpaceatEOL()
  call Preserve("%s/\\s\\+$//e")
endfunction
" automatically delete trailing blank lines on save
function! TrimEndLines()
  call Preserve("%s#\\($\\n\\s*\\)\\+\\%$##")
endfunction
" auto-delete blank lines on save
autocmd BufWritePre * call TrimEndLines() | call TrimSpaceatEOL()
" auto-reload vimrc after changes
autocmd BufWritePost .vimrc source $MYVIMRC

nmap <silent> *  :let @/='\v<'.expand('<cword>').'>'<CR>:let v:searchforward=1<CR>n
nmap <silent> #  :let @/='\v<'.expand('<cword>').'>'<CR>:let v:searchforward=0<CR>n
nmap <silent> g* :let @/='\v'.expand('<cword>')<CR>:let v:searchforward=1<CR>n
nmap <silent> g# :let @/='\v'.expand('<cword>')<CR>:let v:searchforward=0<CR>n
nnoremap <CR> :noh<CR>
" when wanting to change some, but not necessarily all occurences of a "word"
nnoremap c* *Ncgn
" use <S>Q to run a command (text) in current buffer
noremap Q !!$SHELL<CR>
syntax enable             "Turn on syntax highlighting
filetype plugin indent on

set encoding=utf-8  "Force UTF-8 encoding for special characters
set number          "Show line numbers
set relativenumber  "Show relative line numbers
"set cursorline      "underline the current line in the file
"set cursorcolumn    "highlight the current column
set lazyredraw      "redraw only when needed (e.g. until macro is over)

set background=dark "make vim use colors that look good on a dark background
colorscheme solarized

" let g:solarized_termcolors=16
" let g:solarized_termcolors=256

let g:plantuml_executable_script="java -jar $HOME/sw/plantuml-1.2022.14.jar"

set showcmd    "show incomplete cmds down the bottom
set showmode   "show current mode down the bottom
set foldenable "enable folding
set showmatch  "set show matching parenthesis

set hlsearch   "hilight searches by default
set ignorecase "ignore case when searching

set smartcase  "don't ignore case if searching with both cases

set magic " set magic on for regex

set shiftwidth=2   "number of spaces to use in each autoindent step
set tabstop=2      "two tab spaces
set softtabstop=2  "number of spaces to skip or insert when <BS>ing or <Tab>ing
set expandtab      "spaces instead of tabs for better cross-editor compatibility
set shiftround     "when at 3 spaces, and I hit > ... go to 4, not 5
set nowrap         "no wrapping

set smartindent

set noerrorbells          "don't make noise
set wildmode=list:longest "tab complete to longest common string, like bash

set hidden                 "allow hiding buffers with unsaved changes

" ----------- Visual Configuration ----------------------------------
set statusline=%f%m%r%h%w[%{&ff}]%y[%04l,%04v][%n]
"              | | | | |  |      |  |    |     |
"              | | | | |  |      |  |    |     ` current buffer
"              | | | | |  |      |  |    ` current column
"              | | | | |  |      |  `-- current line
"              | | | | |  |      `-- current syntax in
"              | | | | |  |          square brackets
"              | | | | |  `-- current fileformat
"              | | | | `-- preview flag in square brackets
"              | | | `-- help flag in square brackets
"              | | `-- readonly flag in square brackets
"              | `-- modified flag in square brackets
"              `-- full path to file in the buffer

" Exit insert mode with jk
imap jk <Esc>
" Exit insert mode and save with jj
imap jj <Esc>:w<CR>

map <Leader>h :wincmd h<CR>
map <Leader>j :wincmd j<CR>
map <Leader>k :wincmd k<CR>
map <Leader>l :wincmd l<CR>

map <Leader>v :vsplit<CR>
map <Leader>s :split<CR>

map <Leader>d :bd<CR>
map <Leader>q :q<CR>
map <Leader>w :w<CR>

nnoremap <Leader>m :make<CR>

" double percentage sign in command mode is expanded
" to directory of current file - http://vimcasts.org/e/14
cnoremap %% <C-R>=expand('%:h').'/'<CR>

" insert blank line above in Normal mode
nnoremap <Leader>O  mzO<esc>`z
" insert blank line below in Normal mode
nnoremap <Leader>o mzo<esc>`z

" Spell check toggle
map <leader>sp :setlocal spell! spelllang=en_us<CR>

" puts all grep results in the quickfix list
function! ArgsGrepUse(pattern)
  execute 'silent! vimgrep /' . a:pattern . '/j ##'
  cfirst
endfunction
command! -nargs=1 GrepBuffers call ArgsGrepUse(<q-args>)
nnoremap g/ :GrepBuffers<Space>

function! FzyCommand(choice_command, vim_command)
  try
    let output = system(a:choice_command . " | fzy ")
  catch /Vim:Interrupt/
    " Swallow errors from ^C, allow redraw! below
  endtry
  redraw!
  if v:shell_error == 0 && !empty(output)
    exec a:vim_command . ' ' . output
  endif
endfunction

nnoremap <Leader>e :call FzyCommand("git ls-files ", ":e")<CR>
