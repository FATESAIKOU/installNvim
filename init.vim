" ---------------------------
" 基本設定
" ---------------------------
set nocompatible
filetype off

" 編碼
set encoding=utf-8

" 行號
set number
set relativenumber

" 縮排
set tabstop=4
set shiftwidth=4
set expandtab
set smartindent

" 顏色
syntax on
set termguicolors

" ---------------------------
" 初始化 Lazy.nvim
" ---------------------------
lua << EOF
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Treesitter
  {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},

  -- LSP & Mason
  {"neovim/nvim-lspconfig"},
  {"williamboman/mason.nvim"},
  {"williamboman/mason-lspconfig.nvim"},

  -- Telescope
  {"nvim-telescope/telescope.nvim", dependencies = {"nvim-lua/plenary.nvim"}},

  -- Git
  {"lewis6991/gitsigns.nvim"},
  {"tpope/vim-fugitive"},

  -- Snippets & Completion
  {"L3MON4D3/LuaSnip"},
  {"hrsh7th/nvim-cmp"},
  {"saadparwaiz1/cmp_luasnip"},
  {"hrsh7th/cmp-nvim-lsp"},
  {"hrsh7th/cmp-buffer"},

  -- UI
  {"nvim-lualine/lualine.nvim"},
  {"nvim-tree/nvim-web-devicons"},
  {"lukas-reineke/indent-blankline.nvim"},
  {"akinsho/bufferline.nvim"},
  {"projekt0n/github-nvim-theme", name="github-theme"},

  -- 檔案樹
  {"nvim-tree/nvim-tree.lua"},

  -- Undo Tree
  {"mbbill/undotree"},

  -- Markdown Preview
  {"iamcco/markdown-preview.nvim", build = "cd app && npm install", ft = {"markdown"}},

  -- Github Copilot
  {
    "github/copilot.vim",
    lazy=false,
  },
})

vim.cmd[[colorscheme github_dark]]
EOF

" ---------------------------
" Plugin 設定
" ---------------------------
" Treesitter 啟動
lua << EOF
require('nvim-treesitter.configs').setup {
  highlight = { enable = true },
}
EOF

" Gitsigns 啟動
lua << EOF
require('gitsigns').setup()
EOF

" Lualine 啟動
lua << EOF
require('lualine').setup()
EOF

" Bufferline 啟動
lua << EOF
require('bufferline').setup{}
EOF

" Indent-blankline 啟動
lua << EOF
require("ibl").setup {
    indent = {
        char = "│",
    },
    scope = {
        enabled = true,
    },
}
EOF

" NvimTree 啟動
lua << EOF
require("nvim-tree").setup()
EOF

" ---------------------------
" Mason & LSP 設定
" ---------------------------
lua << EOF
-- Mason 初始化與 LSP 自動安裝
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "ts_ls", "pyright", "jdtls" },
    automatic_installation = true,
})

-- LSP 設定
local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- LSP 快捷鍵
local function on_attach(client, bufnr)
    local opts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
end

-- 啟動三個主要 LSP
lspconfig.ts_ls.setup { capabilities = capabilities, on_attach = on_attach }
lspconfig.pyright.setup { capabilities = capabilities, on_attach = on_attach }
lspconfig.jdtls.setup { capabilities = capabilities, on_attach = on_attach }
EOF

" ---------------------------
" nvim-cmp 自動補全設定
" ---------------------------
lua << EOF
local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
    snippet = {
        expand = function(args) luasnip.lsp_expand(args.body) end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    },
})
EOF

" ---------------------------
" 快捷鍵
" ---------------------------
" UndoTree
nnoremap <F5> :UndotreeToggle<CR>

" Markdown Preview
autocmd FileType markdown nnoremap <F6> :MarkdownPreview<CR>

" NvimTree (檔案樹)
nnoremap <F2> :NvimTreeToggle<CR>

" Buffer 切換
nmap ,n :bn!<CR>
nmap ,p :bp!<CR>

" Tab 操作
nnoremap <Leader>tn :tabnew<CR>
nnoremap <Leader>to :tabonly<CR>
nnoremap <Leader>tc :tabclose<CR>
nnoremap <Leader>tm :tabmove
nnoremap <Leader>1 1gt
nnoremap <Leader>2 2gt
nnoremap <Leader>3 3gt

" Split 操作
nnoremap <Leader>sh :split<CR>
nnoremap <Leader>sv :vsplit<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Telescope 檔案名搜尋
nnoremap <Leader>f :Telescope find_files<CR>

" Telescope 內容全文搜尋 (live grep)
nnoremap <Leader>g :Telescope live_grep<CR>
