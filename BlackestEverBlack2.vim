" Vim colorscheme template file
" Hi, me and David edited this because it was pretty close 
" the original was:
" Author: Gerardo Galindez <gerardo.galindez@gmail.com>
" Maintainer: Gerardo Galindez <gerardo.galindez@gmail.com>
" Notes: To check the meaning of the highlight groups, :help 'highlight'

highlight clear

if exists("syntax_on")
    syntax reset
endif

if has('nvim')
    set termguicolors
endif

let g:colors_name="BlackestEverBlack"

" https://github.com/noahfrederick/vim-hemisu/
function! s:h(group, style)
  execute "highlight" a:group
    \ "guifg="   (has_key(a:style, "fg")    ? a:style.fg.gui   : "NONE")
    \ "guibg="   (has_key(a:style, "bg")    ? a:style.bg.gui   : "NONE")
    \ "guisp="   (has_key(a:style, "sp")    ? a:style.sp.gui   : "NONE")
    \ "gui="     (has_key(a:style, "gui")   ? a:style.gui      : "NONE")
    \ "ctermfg=" (has_key(a:style, "fg")    ? a:style.fg.cterm : "NONE")
    \ "ctermbg=" (has_key(a:style, "bg")    ? a:style.bg.cterm : "NONE")
    \ "cterm="   (has_key(a:style, "cterm") ? a:style.cterm    : "NONE")
endfunction


" color palette
let s:black = { "gui": "#000000", "cterm": "0" }
let s:white = { "gui": "#ffffff", "cterm": "7" }
let s:gray = { "gui": "#555555", "cterm": "8" }

let s:bg = s:black
let s:fg = s:white
let s:visual = s:gray

call s:h("Normal",   {"bg": s:bg, "fg": s:fg})
call s:h("Noise",    {"bg": s:bg, "fg": s:fg})
call s:h("Cursor",   {"bg": s:bg, "fg": s:fg})
call s:h("Comment",  {"fg": s:visual, "bg": s:bg})

call s:h("Constant", {"bg": s:bg, "fg": s:fg})
call s:h("LineNr",   {"bg": s:bg, "fg": s:fg})
call s:h("CursorLineNR", {"bg": s:bg, "fg": s:fg})

" -----------------
" - Number column -
" -----------------
call s:h("CursorColumn",   {"bg": s:bg, "fg": s:fg})
call s:h("FoldColumn",   {"bg": s:bg, "fg": s:fg})
call s:h("SignColumn",   {"bg": s:bg, "fg": s:fg})
call s:h("Folded",   {"bg": s:bg, "fg": s:fg})

" -------------------------
" - Window/Tab delimiters - 
" -------------------------
call s:h("VertSplit",   {"bg": s:bg, "fg": s:fg})
call s:h("ColorColumn",   {"bg": s:bg, "fg": s:fg})
call s:h("TabLine",   {"bg": s:bg, "fg": s:fg})
call s:h("TabLineFill",   {"bg": s:bg, "fg": s:fg})
call s:h("TabLineSel",   {"bg": s:bg, "fg": s:fg})

" -------------------------------
" - File Navigation / Searching -
" -------------------------------
call s:h("Directory",   {"bg": s:bg, "fg": s:fg})
call s:h("Search",   {"bg": s:bg, "fg": s:fg})
call s:h("IncSearch",   {"bg": s:bg, "fg": s:fg})

" -----------------
" - Prompt/Status -
" -----------------
call s:h("StatusLine",   {"bg": s:bg, "fg": s:fg})
call s:h("StatusLineNC",   {"bg": s:bg, "fg": s:bg})
call s:h("WildMenu",   {"bg": s:bg, "fg": s:fg})
call s:h("Question",   {"bg": s:bg, "fg": s:fg})
call s:h("Title",   {"bg": s:bg, "fg": s:fg})
call s:h("ModeMsg",   {"bg": s:bg, "fg": s:fg})
call s:h("MoreMsg",   {"bg": s:bg, "fg": s:fg})

" --------------
" - Visual aid -
" --------------
call s:h("MatchParen",   {"bg": s:visual, "fg": s:fg})
call s:h("Visual",   {"bg": s:fg, "fg": s:bg})
call s:h("VisualNOS",   {"bg": s:bg, "fg": s:fg})
call s:h("NonText",   {"bg": s:bg, "fg": s:fg})
call s:h("Todo",   {"bg": s:bg, "fg": s:fg})

call s:h("Underlined",   {"bg": s:bg, "fg": s:fg})
call s:h("Error",   {"bg": s:bg, "fg": s:fg})
call s:h("ErrorMsg",   {"bg": s:bg, "fg": s:fg})
call s:h("Ignore",   {"bg": s:bg, "fg": s:fg})
call s:h("SpecialKey",   {"bg": s:bg, "fg": s:fg})

" --------------------------------
" Variable types
" --------------------------------
call s:h("Constant",   {"bg": s:bg, "fg": s:fg})
call s:h("String",   {"bg": s:bg, "fg": s:fg})
call s:h("StringDelimiter",   {"bg": s:bg, "fg": s:fg})
call s:h("Character",   {"bg": s:bg, "fg": s:fg})
call s:h("Number",   {"bg": s:bg, "fg": s:fg})
call s:h("Boolean",   {"bg": s:bg, "fg": s:fg})
call s:h("Float",   {"bg": s:bg, "fg": s:fg})

call s:h("Identifier",   {"bg": s:bg, "fg": s:fg})
call s:h("Function",   {"bg": s:bg, "fg": s:fg})


" --------------------------------
" Language constructs
" --------------------------------

call s:h("Statement", {"bg": s:bg, "fg": s:fg})
call s:h("Conditional", {"bg": s:bg, "fg": s:fg})
call s:h("Repeat", {"bg": s:bg, "fg": s:fg})
call s:h("Label", {"bg": s:bg, "fg": s:fg})
call s:h("Operator", {"bg": s:bg, "fg": s:fg})
call s:h("Keyword", {"bg": s:bg, "fg": s:fg})
call s:h("Exception", {"bg": s:bg, "fg": s:fg})
call s:h("Comment", {"bg": s:bg, "fg": s:fg})

call s:h("Special", {"bg": s:bg, "fg": s:fg})
call s:h("SpecialChar", {"bg": s:bg, "fg": s:fg})
call s:h("Tag", {"bg": s:bg, "fg": s:fg})
call s:h("Delimiter", {"bg": s:bg, "fg": s:fg})
call s:h("SpecialComment", {"bg": s:bg, "fg": s:fg})
call s:h("Debug", {"bg": s:bg, "fg": s:fg})

" ----------
" - C like -
" ----------
call s:h("PreProc",   {"bg": s:bg, "fg": s:fg})
call s:h("Include",   {"bg": s:bg, "fg": s:fg})
call s:h("Define",   {"bg": s:bg, "fg": s:fg})
call s:h("Macro",   {"bg": s:bg, "fg": s:fg})
call s:h("PreCondit",   {"bg": s:bg, "fg": s:fg})

call s:h("Type",   {"bg": s:bg, "fg": s:fg})
call s:h("StorageClass",   {"bg": s:bg, "fg": s:fg})
call s:h("Structure",   {"bg": s:bg, "fg": s:fg})
call s:h("Typedef",   {"bg": s:bg, "fg": s:fg})


" --------------------------------
" Diff
" --------------------------------
call s:h("DiffAdd",   {"bg": s:bg, "fg": s:fg})
call s:h("DiffChange",   {"bg": s:bg, "fg": s:fg})
call s:h("DiffDelete",   {"bg": s:bg, "fg": s:fg})
call s:h("DiffText",   {"bg": s:bg, "fg": s:fg})

" --------------------------------
" Completion menu
" --------------------------------
call s:h("Pmenu",   {"bg": s:bg, "fg": s:fg})
call s:h("PmenuSel",   {"bg": s:fg, "fg": s:bg})
call s:h("PmenuSbar",   {"bg": s:bg, "fg": s:fg})
call s:h("PmenuThumb",   {"bg": s:bg, "fg": s:fg})

" --------------------------------
" Spelling
call s:h("SpellBad",   {"bg": s:bg, "fg": s:fg})
call s:h("SpellCap",   {"bg": s:bg, "fg": s:fg})
call s:h("SpellLocal",   {"bg": s:bg, "fg": s:fg})
call s:h("SpellRare",   {"bg": s:bg, "fg": s:fg})

"--------------------------------------------------------------------
" Specific settings                                                 |
"--------------------------------------------------------------------

call s:h("EndOfBuffer",  {"bg": s:bg, "fg": s:bg})
