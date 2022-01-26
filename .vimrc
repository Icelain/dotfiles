set number
set numberwidth =1
set guicursor ="i:block"
set termguicolors
set completeopt-=preview
set ts=4 sw=4
set clipboard=unnamedplus
"set ttymouse=sgr
filetype plugin on
syntax on

let g:go_gopls_enabled = 0
let g:go_highlight_function_calls = 1
let g:go_highlight_fields = 5
let g:go_highlight_types = 2
let g:go_code_completion_enabled = 0

let g:neovide_refresh_rate=120
let g:neovide_remember_window_size=v:true
let g:neovide_transparency=0.99

set nocompatible
filetype off

call plug#begin('~/.vim/plugged')

Plug 'fatih/vim-go'
Plug 'tomasiser/vim-code-dark'
Plug 'pangloss/vim-javascript'
Plug 'neoclide/coc.nvim'
Plug 'evanleck/vim-svelte'
Plug 'arzg/vim-rust-syntax-ext'
"Plug 'sainnhe/sonokai'
Plug 'windwp/nvim-autopairs' 
Plug 'morhetz/gruvbox'

call plug#end()

colorscheme codedark

hi! Normal guibg=#101010 ctermbg=NONE
hi! NonText ctermbg=NONE guibg=#171717

highlight clear EndOfBuffer
highlight clear LineNr

nnoremap <silent> <ESC><ESC> :nohlsearch \| match none \| 2match none \| call coc#float#close_all()<CR>

inoremap <silent><nowait><expr> <C-z> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-x> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

" system clipboard
nmap <c-c> "+y
vmap <c-c> "+y
nmap <c-v> "+p
inoremap <c-v> <c-r>+
cnoremap <c-v> <c-r>+
" use <c-r> to insert original character without triggering things like auto-pairs
inoremap <c-r> <c-v>

let g:gruvbox_contrast_dark='hard'

set guifont=jetbrains\ mono\:h11.8
set mouse=a
"set bg=dark

highlight EndOfBuffer guifg=#84c0e8
highlight LineNr guifg=#828282
