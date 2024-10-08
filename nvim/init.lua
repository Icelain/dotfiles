vim.cmd [[source ~/.config/nvim/vinit.vim]]

require("nvim-autopairs").setup{
	
	map_cr = false,

}

require('lualine').setup({
    options = {
        -- ...
        theme = 'seoul256',
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
--
--require("mason").setup()
--require("mason-lspconfig").setup()
--
--local cmp = require'cmp'
--
--cmp.setup({
--snippet = {
--  -- REQUIRED - you must specify a snippet engine
--  expand = function(args)
--	vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
--	-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
--	-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
--	-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
--	-- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
--  end,
--},
--window = {
--  -- completion = cmp.config.window.bordered(),
--  -- documentation = cmp.config.window.bordered(),
--},
--mapping = cmp.mapping.preset.insert({
--  ['<C-x>'] = cmp.mapping.scroll_docs(-4),
--  ['<C-z>'] = cmp.mapping.scroll_docs(4),
--  ['<C-Space>'] = cmp.mapping.complete(),
--  ['<C-e>'] = cmp.mapping.abort(),
--  ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
--}),
--sources = cmp.config.sources({
--  { name = 'nvim_lsp' },
--  { name = 'vsnip' }, -- For vsnip users.
--  -- { name = 'luasnip' }, -- For luasnip users.
--  -- { name = 'ultisnips' }, -- For ultisnips users.
--  -- { name = 'snippy' }, -- For snippy users.
--}, {
--  { name = 'buffer' },
--})
--})
--
---- Set configuration for specific filetype.
--cmp.setup.filetype('gitcommit', {
--sources = cmp.config.sources({
--  { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
--}, {
--  { name = 'buffer' },
--})
--})
--
--local cfg = {
--
--	hint_enable = false
--
--}  -- add your config here
--require "lsp_signature".setup(cfg)
--
---- Set up lspconfig.
--local capabilities = require('cmp_nvim_lsp').default_capabilities()
--require("mason-lspconfig").setup_handlers {
--	-- The first entry (without a key) will be the default handler
--	-- and will be called for each installed server that doesn't have
--	-- a dedicated handler.
--	function (server_name) -- default handler (optional)
--		require("lspconfig")[server_name].setup {}
--	end,
--	-- Next, you can provide a dedicated handler for specific servers.
--	-- For example, a handler override for the `rust_analyzer`:
--
--}
