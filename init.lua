vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.tabstop = 2
vim.opt.swapfile = false
vim.opt.winborder = "rounded"
vim.g.mapleader = " "	--sets <leader>, currently 'space'

vim.pack.add({
		{src = "https://github.com/vague2k/vague.nvim"},
		{src = "https://github.com/stevearc/oil.nvim"},
		{src = "https://github.com/echasnovski/mini.nvim"},
		-- {src = "https://github.com/neovim/nvim-lspconfig"},		-- use embedded instead
		{src = "https://github.com/mason-org/mason.nvim"},
		{src = "https://github.com/gelguy/wilder.nvim"},
		{src = "https://github.com/nvim-treesitter/nvim-treesitter"},
})
require("mason").setup()
require("mini.pick").setup()
require("oil").setup()
require "nvim-treesitter.configs".setup({
    ensure_installed = { "typescript", "javascript", "css", "html", "json" },
		highlight = { enabled = true }
})

vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>')
vim.keymap.set('n', '<leader>w', ':write<CR>')
vim.keymap.set('n', '<leader>q', ':quit<CR>')
vim.keymap.set('n', '<leader>f', ':Pick files tool=\'rg\'<CR>')		-- depening on tool, requires this command on your system
vim.keymap.set('n', '<leader>h', ':Pick help<CR>')
vim.keymap.set('n', '<leader>e', ':Oil<CR>')
vim.keymap.set('n', '<leader>cd', ':cd %:p:h<CR>')						-- change pwd to dir of open file
vim.keymap.set({'n', 'v', 'x'}, '<leader>y', '"+y<CR>')				-- system copy
vim.keymap.set({'n', 'v', 'x'}, '<leader>d', '"+d<CR>')				-- system yank (cut)

vim.lsp.enable({"lua_ls", "clang", "gopls", "rust_analyzer"})
-- automatically call <ctrl>xo for completion
vim.api.nvim_create_autocmd('LspAttach' , {
		callback = function(ev)
				local client = vim.lsp.get_client_by_id(ev.data.client_id)
				if client:supports_method('textDocument/completion') then
						vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true } )
				end
		end,
})
-- unselect first suggestion
vim.cmd("set completeopt+=noselect")

--- theme
require("vague").setup({transparent = true})
vim.cmd("colorscheme vague")
vim.cmd(":hi statusline guibg=NONE")

