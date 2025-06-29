" ---------------------------
" 最簡化 Neovim 配置 - 僅 LSP 與自動補全
" ---------------------------

" 基本設定
set number
set expandtab
set tabstop=4
set shiftwidth=4
syntax on
set termguicolors

" 初始化 Lazy.nvim
lua << EOF
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- LSP 相關
  {"neovim/nvim-lspconfig"},
  {"williamboman/mason.nvim"},
  {"williamboman/mason-lspconfig.nvim"},
  
  -- 自動補全
  {"hrsh7th/nvim-cmp"},
  {"hrsh7th/cmp-nvim-lsp"},
  {"L3MON4D3/LuaSnip"},
  {"saadparwaiz1/cmp_luasnip"},
})
EOF

" Mason & LSP 設定
lua << EOF
-- Mason 初始化
require("mason").setup()

-- Mason-lspconfig 自動安裝 LSP
require("mason-lspconfig").setup({
    ensure_installed = { "ts_ls", "pyright", "jdtls" },
    automatic_installation = true,
})

-- LSP 設定
local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- LSP 快捷鍵設定
local function on_attach(client, bufnr)
    local opts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
end

-- 設定三個主要 LSP
lspconfig.ts_ls.setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

lspconfig.pyright.setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

lspconfig.jdtls.setup {
    capabilities = capabilities,
    on_attach = on_attach,
}
EOF

" nvim-cmp 自動補全設定
lua << EOF
local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
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
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
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
