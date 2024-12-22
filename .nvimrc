set cursorline
set mouse=a
"set number
set relativenumber
set numberwidth =3
set termguicolors
set completeopt-=preview
set ts=4 sw=4
set clipboard+=unnamedplus
set signcolumn=no
set cmdheight=0
"set ttymouse=sgr
set noexpandtab
set copyindent
set preserveindent
set softtabstop=0
set list listchars=tab:\ \ 

filetype plugin on
syntax on

"vim-go conf

"let g:go_highlight_functions = 1
"let g:go_gopls_enabled = 0
"let g:go_highlight_function_calls = 1
"let g:go_highlight_fields = 1
"let g:go_highlight_types = 1
"let g:go_code_completion_enabled = 0
"
"let g:neovide_refresh_rate=165
"let g:neovide_remember_window_size=v:true

"vim-go conf end
"let g:neovide_transparency=0.95

set nocompatible
filetype off

call plug#begin('~/.vim/plugged')

"Plug 'fatih/vim-go'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
"Plug 'pangloss/vim-javascript'
Plug 'neoclide/coc.nvim'
"Plug 'evanleck/vim-svelte'
"Plug 'arzg/vim-rust-syntax-ext'
"Plug 'sainnhe/sonokai'
Plug 'windwp/nvim-autopairs' 
"Plug 'morhetz/gruvbox'
"Plug 'vim-airline/vim-airline'
"Plug 'kaicataldo/material.vim', { 'branch': 'main' }
"Plug 'NoahTheDuke/vim-just'
"Plug 'sainnhe/gruvbox-material'
"Plug 'folke/tokyonight.nvim'
"Plug 'rebelot/kanagawa.nvim'
"Plug 'frazrepo/vim-rainbow'
"Plug 'martinsione/darkplus.nvim'
"Plug 'neovim/nvim-lspconfig'
"Plug 'hrsh7th/cmp-nvim-lsp'
"Plug 'hrsh7th/cmp-buffer'
"Plug 'hrsh7th/cmp-path'
"Plug 'hrsh7th/nvim-cmp'
"Plug 'williamboman/mason.nvim'
"Plug 'williamboman/mason-lspconfig.nvim'
Plug 'nvim-lualine/lualine.nvim'
"Plug 'ray-x/lsp_signature.nvim'
Plug 'icelain/vscode.nvim'

call plug#end()

colorscheme vscode


hi! Normal guibg=None ctermbg=NONE
hi! NonText ctermbg=NONE guibg=None

if exists("g:neovide")

	hi! Normal guibg=#0d0d0d ctermbg=NONE
	hi! NonText ctermbg=NONE guibg=#202123
	set linespace=1
	
	set guifont=Agave\ Nerd\ Font\ Mono\:h13
	let g:neovide_padding_top = 2
	let g:neovide_padding_bottom = 2
	let g:neovide_padding_right = 0
	let g:neovide_padding_left = 2

endif


highlight EndOfBuffer guifg=#535353
highlight clear LineNr

"nnoremap <silent> <ESC><ESC> :nohlsearch \| match none \| 2match none \| call coc#float#close_all()<CR>

inoremap <silent><nowait><expr> <C-z> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-x> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

" use <c-r> to insert original character without triggering things like auto-pairs
"inoremap <c-r> <c-v>

"let g:gruvbox_contrast_dark='hard'
"let g:material_theme_style = "darker" 

"set guifont=agave\ nerd\ font\ mono:h13.9

"set bg=dark

nnoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

"au FileType c,cpp,objc,objcpp,go,rust,typescript,json,javascript,lua call rainbow#load()
"let g:rainbow_active=1

"let g:rainbow_guifgs = ["MediumPurple", 'orange3', 'DeepSkyBlue1', 'PaleGreen3', 'LightCyan4', 'PeachPuff1','turquoise4']

"highlight EndOfBuffer guifg=#a3c7c9
highlight LineNr guifg=#636363
highlight CursorLine guibg=#141415 guifg=None
highlight clear CursorLineNR
highlight SignColumn guibg=None
highlight TermCursor guifg=NONE guibg=#ffc799 gui=NONE cterm=NONE
hi! TermCursorNC guibg=#ffc799 gui=NONE cterm=NONE

nnoremap <silent> <C-n> <Cmd>tabnew<CR>
nnoremap <silent> <C-m> <Cmd>tabclose<CR>
nnoremap <silent> <C-j> <Cmd>tabprevious<CR>
nnoremap <silent> <C-k> <Cmd>tabnext<CR>
nnoremap <silent> <C-l> :noh<CR><C-l>
