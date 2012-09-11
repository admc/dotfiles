syntax on
set t_Co=256
colorscheme jellybeans

" Highlight redundant whitespaces.
highlight RedundantSpaces ctermbg=blue guibg=blue
match RedundantSpaces /\s\+$\| \+\ze\t/
" Suppress all spaces at end/beginning of lines
nmap _s :%s/\s\+$//<CR>
nmap _S :%s/^\s\+//<CR>
nmap _j :g/\S/,/^\s*$/join<CR>
nmap _w :set wrap lbr tw=0 co=65<CR>
nmap _t :tabnew 
nmap _l :set nonu<CR>
nmap _L :set nu<CR>

" Turn off auto-indent for paste
set pastetoggle=<F8>

" Line numbahs ...
set nu
" Use actual tabs, ugh
set et
" Indent 2 spaces
set ts=2
set sw=2

" Jump to matching brackets
" set sm
" Auto-indent
set noai

" @ will reformat the current paragraph
map @ !} fmt -w 65

" Cycle through the tabs
map <C-J> :tabp<CR>
map <C-K> :tabn<CR>

:abbr #b /*------------------------------------------------
:abbr #e -----------------------------------------------*/


" Try to autodetect tab-based indentation and go with the flow
function DetectTabs()
    if len(filter(getbufline(winbufnr(0), 1, "$"), 'v:val =~ "^\\t"')) > len(filter(getbufline(winbufnr(0), 1, "$"), 'v:val =~ "^ "'))
        set noet ts=2 sw=2
    endif
endfunction
" autocmd BufReadPost * call DetectTabs()

set hls
set incsearch
