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

set nocompatible                         "don't need to keep compatibility with Vi
syntax enable                            "Turn on syntax highlighting
set encoding=utf-8                       "Force UTF-8 encoding for special characters
set ruler                                "Turn on the ruler
set number                               "Show line numbers
set scrolloff=10                         "Keep 10 lines below cursor always
set cursorline                           "underline the current line in the file
set cursorcolumn                         "highlight the current column. Visible in GUI mode only.

set background=dark                      "make vim use colors that look good on a dark background

colorscheme solarized

set showcmd                              "show incomplete cmds down the bottom
set showmode                             "show current mode down the bottom
set foldenable                           "enable folding
set showmatch                            "set show matching parenthesis

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
set smartindent

set noerrorbells                         "don't make noise
set wildmenu                             "make tab completion act more like bash
set wildmode=list:longest                "tab complete to longest common string, like bash

set mouse=a                              "enable mouse automatically entering visual mode
set hidden                               "allow hiding buffers with unsaved changes

set clipboard=unnamed,unnamedplus                    "Use system clipboard by default

set secure                               "disable unsafe stuff from local .vimrc files

set laststatus=2                         "always show status line

" Set up the backup directories to a central place.
set backupdir=$HOME/tmp/backup//
set directory=$HOME/tmp/backup//

" ----------- Visual Configuration ----------------------------------
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

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

" ----------- Shortcut Key Configuration ----------------------------------
" Exit insert mode with jk
imap jk <Esc>

" Exit insert mode and save with jj
imap jj <Esc>:w<CR>

"CTags
map <Leader>ct :!ctags -R --exclude=.git --exclude=log --exclude=.svn --verbose=yes * <CR>

" pastetoggle just in case
set pastetoggle=<F2>

" Turn text search highlight on/off with F5 key
map <F5> :set hls!<bar>set hls?<CR>

" double percentage sign in command mode is expanded
" to directory of current file - http://vimcasts.org/e/14
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" insert blank line above in Normal mode
nnoremap <Leader>O  mzO<esc>`z

" insert blank line below in Normal mode
nnoremap <Leader>o mzo<esc>`z

" -- Number toggling
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif
endfunc

nnoremap <F6> :call NumberToggle()<cr>

" Spell check toggle
map <leader>sp :setlocal spell! spelllang=en_us<CR>
