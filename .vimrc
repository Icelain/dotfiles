set number
set numberwidth =1
set guicursor ="i:block"
set mouse=a
set termguicolors
set completeopt-=preview
set ts=4 sw=4
set clipboard=unnamedplus
set ttymouse=sgr
filetype plugin on
syntax on



let g:go_gopls_enabled = 0
let g:go_highlight_function_calls = 1
let g:go_highlight_fields = 5
let g:go_highlight_types = 2
let g:go_code_completion_enabled = 0

set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'tomasiser/vim-code-dark'
Plugin 'pangloss/vim-javascript'
Plugin 'neoclide/coc.nvim'
Plugin 'evanleck/vim-svelte'
Plugin 'arzg/vim-rust-syntax-ext'

call vundle#end()
filetype plugin indent on

"st config"
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

colorscheme codedark
hi! Normal guibg=NONE ctermbg=NONE
hi! NonText ctermbg=NONE guibg=NONE
highlight clear EndOfBuffer
highlight clear LineNr
highlight EndOfBuffer guifg=#84c0e8
highlight LineNr guifg=#a13255

nnoremap <silent> <ESC><ESC> :nohlsearch \| match none \| 2match none \| call coc#float#close_all()<CR>
