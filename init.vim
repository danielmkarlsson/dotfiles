set guicursor=
set wm=5

filetype plugin indent on  " detect plugin filetypes
syntax enable              " syntax highlighting

" vim-plug
call plug#begin('~/.config/nvim/bundle')

"Plug 'SirVer/ultisnips'
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"Plug 'deoplete-plugins/deoplete-tag'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'itchyny/calendar.vim'
"Plug 'xarthurx/taskwarrior.vim'
Plug 'jdhao/better-escape.vim'
Plug 'davidgranstrom/scnvim' 
Plug 'Rasukarusan/vim-block-paste'
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-lua/plenary.nvim' 
Plug 'nvim-telescope/telescope.nvim'
Plug 'mkropat/vim-tt'
Plug 'miyakogi/seiya.vim'
Plug '/Users/danielmkarlsson/Documents/GitHub/replay.nvim'
call plug#end()

"autocmd FileType scnvim setlocal wrap

" get dem snips
"let g:UltiSnipsSnippetDirectories = ['UltiSnips', 'scnvim-data']

" see time pass
"set statusline=[%{strftime('%d/%m/%y\ %H:%M\')}\]\ %=\

" set runtimepath+=~/.config/nvim/bundle/deoplete.nvim

" set path to python
let g:python3_host_prog = "/usr/bin/python"

" snips get to autocomplete
" let g:deoplete#enable_at_startup = 1

" the statusline is made anew
function! s:set_sclang_statusline()
  setlocal stl=
  setlocal stl+=%f
  setlocal stl+=%=
  setlocal stl+=%(%l,%c%)
  setlocal stl+=\ \|
  setlocal stl+=%26.26{scnvim#statusline#server_status()}
endfunction

augroup scnvim_stl
  autocmd!
  autocmd FileType supercollider call <SID>set_sclang_statusline()
augroup END

" comment out stuff with this in scnvim
autocmd FileType supercollider setlocal commentstring=//%s 

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
set fillchars+=vert:\               " remove the fillchars from folds and splits
"set listchars=tab:>-,trail:–,nbsp:• " custom list chars
set nostartofline                   " keep the cursor at the current column when moving
set scrolloff=4                     " keep a distance of from the cursor when scrolling
set wrap                            " wrap words
set linebreak                       " break at word boundries for wrapped text
"set nolinebreak                     " do not break at word boundries for wrapped text
set textwidth=80                    " be cool, old school 4:3 text width
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

" fzf
let g:fzf_layout = { 'window': 'call CreateCenteredFloatingWindow()' }

" indenting/formating
set autoindent                      " indent even if we have no filetype rules
set smarttab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab                       " use whitespace instead of tabs
set shiftround                      " round indent to multiples of 'shiftwidth'

" colorscheme/appearance
" hi Normal guibg=NONE ctermbg=NONE
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

" start scnvim w/ space+st
nnoremap <leader>st :SCNvimStart<cr>

" boot the server w/ space+b
nnoremap <leader>sb :call scnvim#sclang#send_silent('s.boot')<cr>

" recompile the class library in scnvim w/ space+sk
nnoremap <leader>sk :SCNvimRecompile<cr>
 
" remap hard stop
" map <C-w> <plug>(scnvim-hard-stop)

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
nnoremap <silent><left> :3wincmd <<cr>
nnoremap <silent><right> :3wincmd ><cr>
nnoremap <silent><down> :3wincmd +<cr>
nnoremap <silent><up> :3wincmd -<cr>

" never enter Ex mode
nnoremap Q <Nop>

command! StartUp :e ~/Library/Application\ Support/SuperCollider/startup.scd

" gcal in vim
"let g:calendar_google_calendar = 1

" log all yank operations with a timestamp and store the contents in a file
function! s:write_yank_to_log() abort
  let path = '/tmp/yank-log.txt'
  let regcontents = get(v:event, 'regcontents', '')
  let stamp = strftime('[%F %T]') " NOTE: formatting is OS specific
  let data = []
  for line in regcontents
    call add(data, stamp . ' ' . line)
  endfor
  call writefile(data, path, 'a')
endfunction

augroup yank_log
  autocmd!
  autocmd TextYankPost * call s:write_yank_to_log()
augroup END

lua << EOF
require('replay').setup{}
require('replay').register_injection('scnvim_eval', require('scnvim.editor').send_block)

local scnvim = require 'scnvim'
local map = scnvim.map
local map_expr = scnvim.map_expr

local function get_pandoc_path()
  local sysname = require('scnvim.path').get_system()
  if sysname == 'linux' then
    return '/bin/pandoc'
  elseif sysname == 'macos' then
    return '/usr/local/bin/pandoc'
  else
    return '/opt/homebrew/bin/pandoc'
  end
end

--local emptylake = require('scnvim_emptylake')

-- ['<M-L>'] = map(function()
--      require('scnvim.postwin').clear()

scnvim.setup({
  keymaps = {
    ['<C-s>'] = map('editor.send_line', {'i', 'n'}),
--    ['<C-e>'] = map(function()
--      require('replay').inject('scnvim_eval')
--      require('scnvim.editor').send_block()
--      end, {'i', 'n'}),
    ['<C-e>'] = {
                      map('editor.send_block', {'i', 'n'}, {desc ="evaluate block"}),
                      map('editor.send_selection', 'x', {desc ="evaluate selection"}),
                  },
    ['<CR>'] = map('postwin.toggle'),
    ['<M-CR>'] = map('postwin.toggle', 'i'),
    -- ['<C-p>'] = map('postwin.clear', {'n', 'i'}),
    ['<C-p>'] = map(function()
    require('scnvim.postwin').clear()
    -- "emptylake.last_col = 0
    end, {'n', 'i'}),
    ['<C-k>'] = map('signature.show', {'n', 'i'}),
    ['<F12>'] = map('sclang.hard_stop', {'n', 'x', 'i'}),
    ['<leader>st'] = map('sclang.start'),
    ['<leader>sk'] = map('sclang.recompile'),
    ['<F1>'] = map_expr('s.boot'),
    ['<leader>sm'] = map_expr('s.meter'),
  },
  editor = {
    highlight = {
    color = 'TermCursor', -- try 'IncSearch' for red highlights
    },
  },
  documentation = {
    cmd = '/usr/local/bin/pandoc',
  },
  postwin = {
    highlight = false,
    auto_toggle_error = true,
    scrollback = 5000,
    horizontal = false,
    direction = 'right',
    size = 30,
  },
  editor = {
    force_ft_supercollider = true,
    highlight = {
      color = 'TermCursor',
      type = 'flash',
      flash = {
        duration = 100,
        repeats = 2,
      },
      fade = {
        duration = 375,
      },
    },
  },
  statusline = {
      poll_interval = 0.5,
  },
})

-- redraw the statusline to update server info
local timer = vim.loop.new_timer()
timer:start(500, 500, vim.schedule_wrap(function()
  vim.cmd[[redrawstatus]]
end))

local replay = require'replay'
      replay.setup{
        output_path = "~/Documents/replay.nvim",
      }
      vim.keymap.set('n', '<F5>', function() replay.record('test') end)
      vim.keymap.set('n', '<F7>', function() replay.play('test') end)

EOF

"    ['<C-p>'] = map('postwin.clear', {'n', 'i'}),
