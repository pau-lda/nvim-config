vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.scrolloff = 5

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smarttab = true    -- indent deletion on backspace
vim.opt.smartindent = true -- ident on newline

vim.opt.swapfile = false
vim.opt.winborder = "rounded"
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"
vim.opt.undofile = true
vim.opt.ignorecase = true

vim.g.mapleader = " " --sets <leader>, currently 'space'
vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>')
vim.keymap.set('n', '<leader>w', ':write<CR>')
vim.keymap.set('n', '<leader>q', ':quit<CR>')
vim.keymap.set('n', '<leader>f', ':Pick files tool=\'rg\'<CR>') -- depending on tool, requires this command on your system
vim.keymap.set('n', '<leader>h', ':Pick help<CR>')
vim.keymap.set('n', '<leader>e', ':Oil<CR>')
vim.keymap.set('n', '<leader>cd', ':cd %:p:h<CR>')  -- change pwd to dir of open file
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>nvim', ':e $MYVIMRC<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>y', '"+y') -- system copy, press motion ($,w,y) after
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>d', '"+d') -- system yank (cut)
vim.keymap.set('n', "<C-d>", "<C-d>zz")             -- recenter after page down
vim.keymap.set('n', "<C-u>", "<C-u>zz")             -- recenter after page up
vim.keymap.set('n', "n", "nzz")
vim.keymap.set('n', "N", "Nzz")
vim.keymap.set({ 'n', 'v' }, '<C-c>', '<Esc>')
vim.keymap.set('n', 'Q', '<nop>')
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]])

vim.pack.add({
    { src = "https://github.com/vague2k/vague.nvim" },
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/echasnovski/mini.nvim" },
    -- {src = "https://github.com/neovim/nvim-lspconfig"},		-- use embedded instead
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/gelguy/wilder.nvim" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
})
require("mason").setup()
require("mini.pick").setup()
require("oil").setup()
require "nvim-treesitter.configs".setup({
    auto_install = true,
    highlight = { enable = true }
})

vim.lsp.enable({ "lua_ls", "clang", "gopls", "rust_analyzer" })
-- automatically call <ctrl>xo for completion
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        print("mapleader: ", vim.inspect(vim.g.mapleader))
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local opts = { buffer = ev.buf }
        if client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
        end
        vim.keymap.set('n', '<leader>lf', function() vim.lsp.buf.format() end, opts)
    end,
})
-- unselect first suggestion
vim.cmd("set completeopt+=noselect")

--- theme
require("vague").setup({ transparent = true })
vim.cmd("colorscheme vague")
vim.cmd(":hi statusline guibg=NONE")
