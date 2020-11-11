" Vim colorscheme template file
" Hi, me and David edited this because it was pretty close so the
" original was:
" Author: Gerardo Galindez <gerardo.galindez@gmail.com>
" Maintainer: Gerardo Galindez <gerardo.galindez@gmail.com>
" Notes: To check the meaning of the highlight groups, :help 'highlight'

highlight clear
if exists("syntax_on")
    syntax reset
endif

let g:colors_name="BlackestEverBlack"

"----------------------------------------------------------------
" General settings                                              |
"----------------------------------------------------------------
"----------------------------------------------------------------
" Syntax group   | Foreground    | Background    | Style        |
"----------------------------------------------------------------

" --------------------------------
" Editor settings
" --------------------------------
hi Normal          ctermfg=7    ctermbg=none    cterm=none
hi Cursor          ctermfg=7    ctermbg=none    cterm=none
hi LineNr          ctermfg=7    ctermbg=none    cterm=none
hi CursorLineNR    ctermfg=7    ctermbg=none    cterm=none

" -----------------
" - Number column -
" -----------------
hi CursorColumn    ctermfg=7    ctermbg=none    cterm=none
hi FoldColumn      ctermfg=7    ctermbg=none    cterm=none
hi SignColumn      ctermfg=7    ctermbg=none    cterm=none
hi Folded          ctermfg=7    ctermbg=none    cterm=none

" -------------------------
" - Window/Tab delimiters - 
" -------------------------
hi VertSplit       ctermfg=none    ctermbg=none    cterm=none
hi ColorColumn     ctermfg=7    ctermbg=none    cterm=none
hi TabLine         ctermfg=7    ctermbg=none    cterm=none
hi TabLineFill     ctermfg=7    ctermbg=none    cterm=none
hi TabLineSel      ctermfg=7    ctermbg=none    cterm=none

" -------------------------------
" - File Navigation / Searching -
" -------------------------------
hi Directory       ctermfg=7    ctermbg=none    cterm=none
hi Search          ctermfg=7    ctermbg=none    cterm=none
hi IncSearch       ctermfg=7    ctermbg=none    cterm=none

" -----------------
" - Prompt/Status -
" -----------------
hi StatusLine      ctermfg=7    ctermbg=none    cterm=none
hi StatusLineNC    ctermfg=none ctermbg=none    cterm=none
hi WildMenu        ctermfg=7    ctermbg=none    cterm=none
hi Question        ctermfg=7    ctermbg=none    cterm=none
hi Title           ctermfg=7    ctermbg=none    cterm=none
hi ModeMsg         ctermfg=7    ctermbg=none    cterm=none
hi MoreMsg         ctermfg=7    ctermbg=none    cterm=none

" --------------
" - Visual aid -
" --------------
hi MatchParen      ctermfg=7    ctermbg=none    cterm=none
hi Visual          ctermfg=0    ctermbg=7       cterm=none
hi VisualNOS       ctermfg=7    ctermbg=none    cterm=none
hi NonText         ctermfg=7    ctermbg=none    cterm=none

hi Todo            ctermfg=7    ctermbg=none    cterm=none
hi Underlined      ctermfg=7    ctermbg=none    cterm=none
hi Error           ctermfg=7    ctermbg=none    cterm=none
hi ErrorMsg        ctermfg=7    ctermbg=none    cterm=none
hi WarningMsg      ctermfg=7    ctermbg=none    cterm=none
hi Ignore          ctermfg=7    ctermbg=none    cterm=none
hi SpecialKey      ctermfg=7    ctermbg=none    cterm=none

" --------------------------------
" Variable types
" --------------------------------
hi Constant        ctermfg=7    ctermbg=none    cterm=none
hi String          ctermfg=7    ctermbg=none    cterm=none
hi StringDelimiter ctermfg=7    ctermbg=none    cterm=none
hi Character       ctermfg=7    ctermbg=none    cterm=none
hi Number          ctermfg=7    ctermbg=none    cterm=none
hi Boolean         ctermfg=7    ctermbg=none    cterm=none
hi Float           ctermfg=7    ctermbg=none    cterm=none

hi Identifier      ctermfg=7    ctermbg=none    cterm=none
hi Function        ctermfg=7    ctermbg=none    cterm=none

" --------------------------------
" Language constructs
" --------------------------------
hi Statement       ctermfg=7    ctermbg=none    cterm=none
hi Conditional     ctermfg=7    ctermbg=none    cterm=none
hi Repeat          ctermfg=7    ctermbg=none    cterm=none
hi Label           ctermfg=7    ctermbg=none    cterm=none
hi Operator        ctermfg=7    ctermbg=none    cterm=none
hi Keyword         ctermfg=7    ctermbg=none    cterm=none
hi Exception       ctermfg=7    ctermbg=none    cterm=none
hi Comment         ctermfg=7    ctermbg=none    cterm=none

hi Special         ctermfg=7    ctermbg=none    cterm=none
hi SpecialChar     ctermfg=7    ctermbg=none    cterm=none
hi Tag             ctermfg=7    ctermbg=none    cterm=none
hi Delimiter       ctermfg=7    ctermbg=none    cterm=none
hi SpecialComment  ctermfg=7    ctermbg=none    cterm=none
hi Debug           ctermfg=7    ctermbg=none    cterm=none

" ----------
" - C like -
" ----------
hi PreProc         ctermfg=7    ctermbg=none    cterm=none
hi Include         ctermfg=7    ctermbg=none    cterm=none
hi Define          ctermfg=7    ctermbg=none    cterm=none
hi Macro           ctermfg=7    ctermbg=none    cterm=none
hi PreCondit       ctermfg=7    ctermbg=none    cterm=none

hi Type            ctermfg=7    ctermbg=none    cterm=none
hi StorageClass    ctermfg=7    ctermbg=none    cterm=none
hi Structure       ctermfg=7    ctermbg=none    cterm=none
hi Typedef         ctermfg=7    ctermbg=none    cterm=none

" --------------------------------
" Diff
" --------------------------------
hi DiffAdd         ctermfg=7    ctermbg=none    cterm=none
hi DiffChange      ctermfg=7    ctermbg=none    cterm=none
hi DiffDelete      ctermfg=7    ctermbg=none    cterm=none
hi DiffText        ctermfg=7    ctermbg=none    cterm=none

" --------------------------------
" Completion menu
" --------------------------------
hi Pmenu           ctermfg=7    ctermbg=none    cterm=none
hi PmenuSel        ctermfg=7    ctermbg=none    cterm=none
hi PmenuSbar       ctermfg=7    ctermbg=none    cterm=none
hi PmenuThumb      ctermfg=7    ctermbg=none    cterm=none

" --------------------------------
" Spelling
" --------------------------------
hi SpellBad        ctermfg=red  ctermbg=none    cterm=none
hi SpellCap        ctermfg=1    ctermbg=none    cterm=none
hi SpellLocal      ctermfg=1    ctermbg=none    cterm=none
hi SpellRare       ctermfg=1    ctermbg=none    cterm=none

"--------------------------------------------------------------------
" Specific settings                                                 |
"--------------------------------------------------------------------
hi Normal term=NONE ctermfg=15 ctermbg=0 guifg=white guibg=black
hi EndOfBuffer term=NONE ctermfg=bg ctermbg=bg guifg=bg guibg=bg
