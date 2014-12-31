"Use Vim settings, rather then Vi settings (much better!).
""This must be first, because it changes other options as a side effect.
set nocompatible

"activate pathogen
call pathogen#infect()

"store lots of :cmdline history
set history=1000

set showcmd     "show incomplete cmds down the bottom
set showmode    "show current mode down the bottom

set rtp+=$HOME/.vim/bundle/vundle

"allow backspacing over everything in insert mode
set backspace=indent,eol,start

"show relative line numbers to the cursor
""show the absolute line number of cursor
set relativenumber
set number

"indention
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set expandtab

"folding settings
set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

set incsearch   "find the next match as we type the search
set hlsearch    "hilight searches by default

set wrap        "dont wrap lines
set linebreak   "wrap lines at convenient points

"some stuff to get the mouse going in term
set mouse=a
set ttymouse=xterm2

"tell the term has 256 colors
set t_Co=256

set wildmode=list:longest   "make cmdline tab completion similar to bash
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing

set formatoptions-=o "dont continue comments when pushing o/O

"vertical/horizontal scroll off settings
set scrolloff=3
set sidescrolloff=7
set sidescroll=1

"load ftplugins and indent files
filetype plugin on
filetype indent on

if v:version >= 703
  "undo settings
  set undodir=~/.vim/undofiles
  set undofile
  set colorcolumn=+1 "mark the ideal max text width
endif

"set pastetoggle automatically
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

"turn syntax highlighting on
syntax on

call vundle#rc()
Bundle 'gmarik/vundle'
filetype plugin indent on

" ALL OF THE ABOVE IS ALSO REQUIRED
" FOR SUCCESSFUL VUNDLE INSTALL
" THE FOLLOWING IS NEW FOR US…

Bundle 'kien/ctrlp.vim'
Bundle 'vim-scripts/The-NERD-tree'
Plugin 'thoughtbot/vim-rspec'
Plugin 'bling/vim-airline'
Plugin 'godlygeek/tabular'
Plugin 'https://github.com/ngmy/vim-rubocop'
Plugin 'https://github.com/tpope/vim-commentary'
Plugin 'https://github.com/tpope/vim-endwise'
Plugin 'esneider/YUNOcommit.vim'

"open NERDTree if no file was specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"map NERDTree to ctrl-n
map <C-n> :NERDTreeToggle<CR>

"close vim if only present window is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" mark everthing longer than 80 red
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

" RSpec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

"THIS REMOVES ALL TRAILING WHITESPACES ON WRITEBUFFER/SAVE
fun! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfun

autocmd FileType c,cpp,java,php,ruby,python autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
