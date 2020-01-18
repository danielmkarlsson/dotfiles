set guicursor=

filetype plugin indent on  " detect plugin filetypes
syntax enable              " syntax highlighting

" vim-plug
call plug#begin('~/.config/nvim/bundle')

Plug 'SirVer/ultisnips'
Plug 'Shougo/deoplete.nvim'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'itchyny/calendar.vim'
Plug 'xarthurx/taskwarrior.vim'
Plug 'davidgranstrom/scnvim', { 'do': ':UpdateRemotePlugins' }

call plug#end()

" get dem snips
let g:UltiSnipsSnippetDirectories = ['UltiSnips', 'scnvim-data']

" set path to deoplete
set runtimepath+=~/.config/nvim/bundle/deoplete.nvim

" snips get to autocomplete
let g:deoplete#enable_at_startup = 1

" the statusline is made anew
function! s:set_sclang_statusline()
  setlocal stl=
  setlocal stl+=%f
  setlocal stl+=%=
  setlocal stl+=%(%l,%c%)
  setlocal stl+=\ \|
  setlocal stl+=%18.18{scnvim#statusline#server_status()}
endfunction

augroup scnvim_stl
  autocmd!
  autocmd FileType supercollider call <SID>set_sclang_statusline()
augroup END

" comment out stuff with this in scnvim
autocmd FileType supercollider setlocal commentstring=//%s 

" scnvim starts autoMagically when .scd files are opened in nvim
let s:scnvim_running = v:false
function! s:start_sclang() abort
  if !s:scnvim_running
    SCNvimStart
    let s:scnvim_running = v:true
  endif
endfunction

augroup scnvim_start
  autocmd!
  autocmd FileType supercollider call <SID>start_sclang()
augroup END

set directory^=$HOME/.vim/.swap//       " put all swap files in one place
let mapleader="\<space>"                " set mapleader
let maplocalleader=","
set mouse=a                             " enable mouse
set nonumber

" editing
set backspace=2                     " allow backspacing over indent, eol, and the start of an insert
set virtualedit=onemore             " get at those pesky endbits (previously all)
set hidden                          " be able to hide modified buffers
set complete-=i                     " where to look for auto-completion
set clipboard+=unnamedplus          " yank to system-wide clipboard
set autoread                        " reload buffers changed from the outside
set completeopt-=preview            " don't display scratch buffer for completion
set formatoptions+=rj               " auto insert comments from insert mode,
                                    " remove comment leader when joining lines
" appearance
" set fillchars=                    " remove the fillchars from folds and splits
"set listchars=tab:>-,trail:–,nbsp:• " custom list chars
set nostartofline                   " keep the cursor at the current column when moving
set scrolloff=4                     " keep a distance of from the cursor when scrolling
set wrap                            " wrap words
set linebreak                       " break at word boundries for wrapped text
" set textwidth=80                    " be cool, old school 4:3 text width
" set list                          " show unprintable characters
" set relativenumber                " 0 on the line you are presently on

augroup WrapLineInscdFile
    autocmd!
    autocmd FileType scd setlocal nowrap
    autocmd FileType scd setlocal nolinebreak
augroup END

" searching
set ignorecase                      " ignore case in search patterns
set incsearch                       " incrementally match the search
set smartcase                       " overrides 'ignorecase' if search pattern contains an upper char
set showmatch                       " highlight search matches while typing

" misc
set ttyfast                         " assume fast terminal connection
set wildmenu                        " enhanced command line completion
set wildignorecase                  " be smart case-sensitive
set diffopt+=vertical               " use vertical diffs by default
set laststatus=2                    " always display a status line
" set autochdir                       " change to cwd of current file
set visualbell                      " turn off error beep/flash
set regexpengine=0                  " use the improved regexpengine
set timeoutlen=1000                 " shorter timeout lenght for keystrokes
set ttimeoutlen=50                  " make esc work faster
set lazyredraw                      " don't redraw screen for macros

" indenting/formating
set autoindent                      " indent even if we have no filetype rules
set smarttab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab                       " use whitespace instead of tabs
set shiftround                      " round indent to multiples of 'shiftwidth'

" colorscheme/appearance
set background=dark
colorscheme BlackestEverBlack2

" use par to format text
if executable("par")
    set formatprg=par\ -w80qr
endif

" let &t_SI = "\<Esc>]50;CursorShape=4\x7"
" let &t_EI = "\<Esc>]50;CursorShape=4\x7"

augroup vimrc
    autocmd!
augroup END

" Key mappings
" ============

" be able to navigate wrapped lines
nnoremap j gj
nnoremap k gk

inoremap jk <esc>
inoremap § <esc> 
nnoremap <C-z> <nop>
nnoremap Y y$

" move a step to the right in insert mode
inoremap <C-l> <C-o>l

" be able to browse help
nnoremap å ]

nnoremap <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
            \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
            \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Disable Arrow keys in Escape mode
 map <up> <nop>
 map <down> <nop>
 map <left> <nop>
 map <right> <nop>
"
" " Disable Arrow keys in Insert mode
 imap <up> <nop>
 imap <down> <nop>
 imap <left> <nop>
 imap <right> <nop>
 
" silence Ctrl-c warn
nnoremap <C-c> <silent> <C-c>

" single line
nmap <C-s> <Plug>(scnvim-send-line)
imap <C-s> <c-o><Plug>(scnvim-send-line)
nmap <C-p> <Plug>(scnvim-postwindow-clear)
imap <C-p> <c-o><Plug>(scnvim-postwindow-clear)

" start scnvim w/ c+st
nnoremap <leader>st :SCNvimStart<cr>

" bring up the meter in scnvim w/ c+m
nnoremap <leader>sm :call scnvim#sclang#send_silent('s.meter')<cr>

" boot the server w/ c+b
nnoremap <leader>sb :call scnvim#sclang#send_silent('s.boot')<cr>

" recompile the class library in scnvim w/ c+sk
nnoremap <leader>sk :SCNvimRecompile<cr>
 
" post window at the bottom
let g:scnvim_postwin_orientation = 'h'

" set this variable to browse SuperCollider documentation in nvim (requires `pandoc`)
let g:scnvim_scdoc = 1

" default is half the terminal size for vertical and a third for horizontal
let g:scnvim_postwin_size = 1 

" path to the sclang executable
" let g:scnvim_sclang_executable = '/Applications/SuperCollider-bleeds/SuperCollider.app'

if &term =~ "xterm\\|rxvt"
  " use an orange cursor in insert mode
  " let &t_SI = "\<Esc>]12;orange\x7"
  " use a red cursor otherwise
  " let &t_EI = "\<Esc>]12;red\x7"
silent !echo -ne "\033]12;red\007"
  " reset cursor when vim exits
  autocmd VimLeave * silent !echo -ne "\033]112\007"
  " use \003]12;gray\007 for gnome-terminal and rxvt up to version 9.21
endif

augroup vimrc
    autocmd VimResized * redraw!
augroup END

" resize windows with arrow-keys
nnoremap <silent><C-h> :3wincmd <<cr>
nnoremap <silent><C-l> :3wincmd ><cr>
nnoremap <silent><C-k> :3wincmd +<cr>
nnoremap <silent><C-j> :3wincmd -<cr>

command! InsertDate :r!date "+\%Y-\%m-\%d"<cr>
inoremap <C-k> <c-o>:InsertDate<cr>

command! StartUp :e ~/Library/Application\ Support/SuperCollider/startup.scd

" gcal in vim
let g:calendar_google_calendar = 1
