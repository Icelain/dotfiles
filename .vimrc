set cursorline
set mouse=a
set number
set relativenumber
set numberwidth =1
set termguicolors
set guicursor=i:block
set completeopt-=preview
set ts=4 sw=4
set clipboard+=unnamedplus
"set ttymouse=sgr
filetype plugin on
syntax on

"vim-go conf

let g:go_highlight_functions = 1
let g:go_gopls_enabled = 0
let g:go_highlight_function_calls = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_code_completion_enabled = 0

let g:neovide_refresh_rate=120
let g:neovide_remember_window_size=v:true

"vim-go conf end
"let g:neovide_transparency=0.95

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
"Plug 'windwp/nvim-autopairs' 
Plug 'morhetz/gruvbox'
"Plug 'vim-airline/vim-airline'
Plug 'kaicataldo/material.vim', { 'branch': 'main' }

call plug#end()

colorscheme material 

hi! Normal guibg=None ctermbg=NONE
hi! NonText ctermbg=NONE guibg=None

if exists("g:neovide")

	hi! Normal guibg=#131414 ctermbg=NONE
	hi! NonText ctermbg=NONE guibg=#131414

endif

highlight clear EndOfBuffer
highlight clear LineNr

nnoremap <silent> <ESC><ESC> :nohlsearch \| match none \| 2match none \| call coc#float#close_all()<CR>

inoremap <silent><nowait><expr> <C-z> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-x> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

" use <c-r> to insert original character without triggering things like auto-pairs
inoremap <c-r> <c-v>

let g:gruvbox_contrast_dark='hard'
let g:material_theme_style = "darker" 

set guifont=agave\ code:h13.9

"set bg=dark

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

"highlight EndOfBuffer guifg=#a3c7c9
highlight LineNr guifg=#828282
highlight CursorLine guibg=#1d2021
"highlight CursorLineNR ctermbg=NONE guibg=NONE
