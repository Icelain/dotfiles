-- Basic settings
vim.opt.cursorline = true
vim.opt.mouse = 'a'
vim.opt.relativenumber = true
vim.opt.numberwidth = 3
vim.opt.completeopt:remove('preview')
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.clipboard:append('unnamedplus')
vim.opt.signcolumn = 'no'
vim.opt.termguicolors = true
vim.opt.cmdheight = 0
vim.opt.expandtab = false
vim.opt.copyindent = true
vim.opt.preserveindent = true
vim.opt.softtabstop = 0
vim.opt.list = true
vim.opt.listchars = { tab = '  ' }
vim.opt.guicursor = 'n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,n-v-c-i-ci-ve-r-cr-o:blinkwait700-blinkoff400-blinkon250'

-- Enable filetype plugins and syntax
vim.cmd('filetype plugin on')
vim.cmd('syntax on')

-- Plugins
require('packer').startup(function(use)
    use 'nvim-treesitter/nvim-treesitter'
    use 'neoclide/coc.nvim'
    use 'windwp/nvim-autopairs'
    use 'nvim-lualine/lualine.nvim'
    use 'icelain/vesper.nvim'
end)

-- Colorscheme
vim.cmd('colorscheme vesper')

-- Highlight settings
vim.cmd('hi! Normal guibg=NONE ctermbg=NONE')
vim.cmd('hi! NonText ctermbg=NONE guibg=NONE')

-- Neovide specific settings
if vim.g.neovide then
    vim.cmd([[
        hi! Normal guibg=#0d0d0d ctermbg=NONE
        hi! NonText ctermbg=NONE guibg=#202123
    ]])
    vim.opt.linespace = 1
    vim.opt.guifont = 'Agave Nerd Font Mono:h13'
    vim.g.neovide_padding_top = 2
    vim.g.neovide_padding_bottom = 2
    vim.g.neovide_padding_right = 0
    vim.g.neovide_padding_left = 2
end

-- Additional highlights
vim.cmd([[
    highlight EndOfBuffer guifg=#535353
    highlight clear LineNr
    highlight LineNr guifg=#636363
    highlight CursorLine guibg=#141415 guifg=NONE
    highlight clear CursorLineNR
    highlight SignColumn guibg=NONE
    highlight TermCursor guifg=NONE guibg=#ffc799 gui=NONE cterm=NONE
    highlight TermCursorNC guibg=#ffc799 gui=NONE cterm=NONE
]])

-- Keymaps
local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.keymap.set(mode, lhs, rhs, options)
end

-- CoC specific mappings
vim.cmd([[
    inoremap <silent><nowait><expr> <C-z> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
    inoremap <silent><nowait><expr> <C-x> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
    inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
    nnoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
]])

-- Tab navigation
map('n', '<C-n>', '<Cmd>tabnew<CR>')
map('n', '<C-m>', '<Cmd>tabclose<CR>')
map('n', '<C-j>', '<Cmd>tabprevious<CR>')
map('n', '<C-k>', '<Cmd>tabnext<CR>')
map('n', '<C-l>', ':noh<CR><C-l>')

-- CoC autocmd
vim.cmd([[
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
]])

vim.api.nvim_create_autocmd("ExitPre", {
	group = vim.api.nvim_create_augroup("Exit", { clear = true }),
	command = "set guicursor=a:ver25",
	desc = "Set cursor back to beam when leaving Neovim."
}) 

require("nvim-autopairs").setup{
	
	map_cr = false,

}

require('lualine').setup({
    options = {
        -- ...
        theme = 'vesper',
        -- ...
    },
})

---- tree sitter configuration
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (or "all")
  ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
