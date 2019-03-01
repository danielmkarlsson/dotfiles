set guicursor=

" ==============================================================================
" {{ckest
" {

" let g:instant_markdown_autostart = 0

filetype plugin indent on  " detect plugin filetypes
syntax enable              " syntax highlighting

" vim-plug
call plug#begin('~/.vim/bundle')

function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    if has('nvim')
      !cargo build --release
    else
      !cargo build --release --no-default-features --features json-rpc
    endif
  endif
endfunction

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }

" util
Plug 'munshkr/vim-tidal'
Plug 'cohama/lexima.vim'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'davidgranstrom/scnvim'

" language
Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }
" Plug 'eagletmt/neco-ghc', { 'for': 'haskell' }
Plug  'supercollider/scvim'

" color schemes
Plug 'mhartington/oceanic-next'
Plug 'rakr/vim-one'
Plug 'pgdouyon/vim-yin-yang'
" Plug 'erwandew/supertab'
Plug 'christoomey/vim-tmux-navigator'

call plug#end()

" comment out stuff with this in SuperCollider
autocmd FileType supercollider setlocal commentstring=//%s 

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
"set listchars=tab:>-,trail:‚Äì,nbsp:‚Ä¢ " custom list chars
set nostartofline                   " keep the cursor at the current column when moving
set scrolloff=4                     " keep a distance of from the cursor when scrolling
set wrap                            " wrap words
set linebreak                       " break at word boundries for wrapped text
set textwidth=80                    " be cool, old school 4:3 text width
" set list                          " show unprintable characters
" set relativenumber                " 0 on the line you are presently on

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
inoremap ¬ß <esc> 
nnoremap <C-z> <nop>
nnoremap Y y$

" move a step to the right in insert mode
inoremap <C-l> <C-o>l

let maplocalleader=","

" " tidalvim
" nmap <C-e> <Plug>TidalLineSend
" imap <C-e> <Esc>mz:TidalSend<cr>`za
" xmap <C-e> <Plug>TidalRegionSend
" nmap <C-b> <Plug>TidalParagraphSend

" be able to browse help
nnoremap √• ]

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

" deoplete config
 if has('nvim')
  let g:deoplete#enable_smart_case = 1
  let g:deoplete#auto_complete_delay = 25
  " fix issue with large tag files
  let deoplete#tag#cache_limit_size = 5000000

  " Enable deoplete on InsertEnter
  let g:deoplete#enable_at_startup = 0
  autocmd! InsertEnter * call deoplete#enable()

  inoremap <silent> <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
  inoremap <expr><C-h> deolete#mappings#smart_close_popup()."\<C-h>"
  inoremap <expr><BS> deoplete#mappings#smart_close_popup()."\<C-h>"
endif

" single line
nmap <C-s> <Plug>(scnvim-send-line)
imap <C-s> <c-o><Plug>(scnvim-send-line)

augroup mappings_scvim
    au!

    " au Filetype supercollider setlocal commentstring=//%s
    " au FileType supercollider setlocal ts=4 sts=4 sw=4

    " au Filetype supercollider nmap <buffer> K :call SChelp(expand('<cword>'))<CR>

    " au Filetype supercollider nnoremap <buffer> <C-e> :call SClang_line()<CR>
    " au Filetype supercollider vnoremap <buffer> <C-e> :call SClang_line()<CR>
    " au Filetype supercollider inoremap <buffer> <C-e> <c-o>:call SClang_line()<CR>

    " au Filetype supercollider nnoremap <buffer> <C-b> :call SClang_block()<CR>
    " au Filetype supercollider inoremap <buffer> <C-b> <c-o>:call SClang_block()<CR>

    " au Filetype supercollider nnoremap <buffer> <F12> :call SClangHardstop()<CR>
    " au Filetype supercollider inoremap <buffer> <F12> <c-o>:call SClangHardstop()<CR>

    " au Filetype supercollider nnoremap <buffer> <leader>st :SClangStart<CR>
    " au Filetype supercollider nnoremap <leader>sk :SClangRecompile<CR>
    " au Filetype supercollider nnoremap <buffer>K :call SChelp(expand('<cword>'))<CR>

    " au Filetype supercollider inoremap <C-a> <c-o>:call SCfindArgs()<CR>
    " au Filetype supercollider inoremap <C-Tab> <c-o>:call SCfindArgs()<CR>
    " au Filetype supercollider nnoremap <C-Tab> :call SCfindArgs()<CR>
    " au Filetype supercollider nnoremap ; :call SCfindArgs()<CR>
    " au Filetype supercollider vnoremap <C-Tab> :call SCfindArgsFromSelection()<CR>

    " au Filetype supercollider inoremap <C-p> <c-o>:call jobstart('sc-clear-screen')<cr>
    " au Filetype supercollider nnoremap <C-p> :call jobstart('sc-clear-screen')<cr>
augroup END

" highlight NonText cterm=none ctermfg=0  " set NonText (empty line tildes) to black

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

augroup develop
    autocmd!
    autocmd BufEnter,BufWinEnter ~/code/sites/danielmkarlsson.com/src/**/* nnoremap <cr> :w \| make<cr>
augroup END

let g:scFlash = 1

augroup vimrc
    autocmd VimResized * redraw!
augroup END


command! InsertDate :r!date "+\%Y-\%m-\%d"<cr>
inoremap <C-k> <c-o>:InsertDate<cr>

command! StartUp :e ~/Library/Application\ Support/SuperCollider/startup.scd
