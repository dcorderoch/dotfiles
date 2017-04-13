" Cross-platform Vim Configuration goes in this file
"
" Contents
" Main configuration
" Visual Configuration
" Shortcut Key Configuration
" Plugin Configuration
" Private Configuration

" ----------- Main Configuration ----------------------------------
" Search down into sub-folders
" Provides tab-completion for all file-related tasks
set path=**

" Create the `tags` file (may need to install ctags first)
command! MakeTags !ctags -R .
nnoremap ,html :-1read $HOME/.vim/.skeleton.html<CR>4jwf>a
nnoremap ,reacthtml :-1read $HOME/.vim/.react.skeleton.html<CR>3jwf>a
nnoremap ,reacts :-1read $HOME/.vim/.react.skeleton.js<CR>2jwhi


set nocompatible                         "don't need to keep compatibility with Vi
filetype plugin indent on
syntax enable                                "Turn on syntax highlighting
set encoding=utf-8                       "Force UTF-8 encoding for special characters
set ruler                                "Turn on the ruler
set number                               "Show line numbers
set scrolloff=10                         "Keep 10 lines below cursor always
set cursorline                           "underline the current line in the file
set cursorcolumn                         "highlight the current column. Visible in GUI mode only.
"set colorcolumn=80

set background=dark                      "make vim use colors that look good on a dark background

set showcmd                              "show incomplete cmds down the bottom
set showmode                             "show current mode down the bottom
set foldenable                           "enable folding
set showmatch                            "set show matching parenthesis
"set virtualedit=all                      "allow the cursor to go in to "invalid" places

set incsearch                            "find the next match as we type the search
set hlsearch                             "hilight searches by default
set ignorecase                           "ignore case when searching

set shiftwidth=2                         "number of spaces to use in each autoindent step
set tabstop=2                            "two tab spaces
set softtabstop=2                        "number of spaces to skip or insert when <BS>ing or <Tab>ing
set expandtab                            "spaces instead of tabs for better cross-editor compatibility
set smarttab                             "use shiftwidth and softtabstop to insert or delete (on <BS>) blanks
set shiftround                           "when at 3 spaces, and I hit > ... go to 4, not 5
set nowrap                               "no wrapping

set backspace=indent,eol,start           "allow backspacing over everything in insert mode
"set cindent                              "recommended setting for automatic C-style indentation
"set autoindent                           "automatic indentation in non-C files
"set copyindent                           "copy the previous indentation on autoindenting
set smartindent

set noerrorbells                         "don't make noise
set wildmenu                             "make tab completion act more like bash
set wildmode=list:longest                "tab complete to longest common string, like bash

"set mouse-=a                             "disable mouse automatically entering visual mode
set mouse=a                              "enable mouse automatically entering visual mode
set hidden                               "allow hiding buffers with unsaved changes
"set cmdheight=2                          "make the command line a little taller to hide 'press enter to viem more' text

set clipboard=unnamed,unnamedplus                    "Use system clipboard by default

"set splitright                           "splits open on the right.
"set splitbelow                           "splits open below existing window..

"set exrc                                 "enable per-directory .vimrc files
set secure                               "disable unsafe stuff from local .vimrc files

set laststatus=2                         "always show status line

" Set up the backup directories to a central place.
set backupdir=$HOME/tmp/backup//
set directory=$HOME/tmp/backup//

" ----------- Visual Configuration ----------------------------------
try
  colorscheme mycontrast
catch
  colorscheme murphy
endtry

set statusline=%f%m%r%h%w[%l][%{&ff}]%y[%p%%][%04l,%04v][%n]
"              | | | | |  |   |      |  |     |    |     |
"              | | | | |  |   |      |  |     |    |     + current
"              | | | | |  |   |      |  |     |    |       buffer
"              | | | | |  |   |      |  |     |    + current
"              | | | | |  |   |      |  |     |       column
"              | | | | |  |   |      |  |     +-- current line
"              | | | | |  |   |      |  +-- current % into file
"              | | | | |  |   |      +-- current syntax in
"              | | | | |  |   |          square brackets
"              | | | | |  |   +-- current fileformat
"              | | | | |  +-- number of lines
"              | | | | +-- preview flag in square brackets
"              | | | +-- help flag in square brackets
"              | | +-- readonly flag in square brackets
"              | +-- rodified flag in square brackets
"              +-- full path to file in the buffer

" Use a bar-shaped cursor for insert mode, even through tmux.
if has("gui_running")
  if exists('$TMUX')
      let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
      let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
  else
      let &t_SI = "\<Esc>]50;CursorShape=1\x7"
      let &t_EI = "\<Esc>]50;CursorShape=0\x7"
  endif
endif

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

" ----------- Shortcut Key Configuration ----------------------------------
let mapleader = ","                      "remap leader to ',' which is much easier than '\'

"Switch to previous file with ',spacebar'
nmap <leader><SPACE> <C-^>

" Open Taglist with [,s]
map <Leader>s :TlistToggle<CR>

" Use leader x to remove the current line but not erase buffer
map <Leader>x "_dd

" Use leader l to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" Exit insert mode with jk
imap jk <Esc>

" reload configuration file
map <Leader>r :so $MYVIMRC<CR>

" Exit insert mode and save with jj
imap jj <Esc>:w<CR>

"CTags
map <Leader>ct :!ctags -R --exclude=.git --exclude=log --exclude=.svn --verbose=yes * <CR>

" mapping to make movements operate on 1 screen line in wrap mode
function! ScreenMovement(movement)
   if &wrap
      return "g" . a:movement
   else
      return a:movement
   endif
endfunction
onoremap <silent> <expr> j ScreenMovement("j")
onoremap <silent> <expr> k ScreenMovement("k")
onoremap <silent> <expr> 0 ScreenMovement("0")
onoremap <silent> <expr> ^ ScreenMovement("^")
onoremap <silent> <expr> $ ScreenMovement("$")
nnoremap <silent> <expr> j ScreenMovement("j")
nnoremap <silent> <expr> k ScreenMovement("k")
nnoremap <silent> <expr> 0 ScreenMovement("0")
nnoremap <silent> <expr> ^ ScreenMovement("^")
nnoremap <silent> <expr> $ ScreenMovement("$")

" Supports pasting in from the clipboard
" https://coderwall.com/p/if9mda/automatically-set-paste-mode-in-vim-when-pasting-in-insert-mode
function! WrapForTmux(s)
  if !exists('$TMUX')
    return a:s
  endif

  let tmux_start = "\<Esc>Ptmux;"
  let tmux_end = "\<Esc>\\"

  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

" pastetoggle just in case
set pastetoggle=<F2>


" Navigate tabs
map <leader>1 :tabp<CR>
map <leader>2 :tabn<CR>

" Turn text search highlight on/off with F5 key
map <F5> :set hls!<bar>set hls?<CR>

" double percentage sign in command mode is expanded
" to directory of current file - http://vimcasts.org/e/14
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" insert blank line above in Normal mode
nnoremap <Leader>O  mzO<esc>`z

" insert blank line below in Normal mode
nnoremap <Leader>o mzo<esc>`z

" Sort CSS properties alphabetically
nnoremap <leader>css :g#\({\n\)\@<=#.,/}/sort<cr>

" -- Number toggling
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif
endfunc

nnoremap <F6> :call NumberToggle()<cr>

" Toggle background color for light and dark.
" Default is dark.
function! ColorToggle()
  if(g:colors_name == "mycontrast")
    colorscheme zellner
  else
    colorscheme mycontrast
  endif
endfunc

nnoremap <F8> :call ColorToggle()<cr>

" Spell check toggle
map <leader>sp :setlocal spell! spelllang=en_us<CR>
