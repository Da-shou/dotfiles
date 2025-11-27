-- Keybinding for sourcing
vim.keymap.set('n', '<leader>o', ':update | :source %<CR>')
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)

-- Binding Esc to escape terminal and go to buffer above
vim.keymap.set('t', '<leader><Esc>', "<C-\\><C-n>", {silent = true})

-- Choosing and searching files.
vim.keymap.set('n', '<leader>f', ":Files<CR>")
vim.keymap.set('n', '<leader>h', ":Help<CR>")
vim.keymap.set('n', '<leader>e', ":NvimTreeToggle<CR>")

-- Listing and quitting buffers
vim.keymap.set('n', '<leader>b', ":Buffers<CR>")
vim.keymap.set('n', '<leader>q', ":bdelete<CR>")

-- Markdown formatting
vim.keymap.set('n', '<leader>md', ":Markview<CR>")

-- Run :make command with keybind
vim.keymap.set('n', '<leader>m', ":make<CR>")

-- Toggle relative line number
vim.keymap.set('n', '<leader>lr', ":set invrelativenumber<CR>")

vim.keymap.set('n', '<leader>sm', SwitchMode)

-- LSP-exclusive shortcuts ; only available when an at least 1 LSP is attached
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(event)
		local opts = { buffer = event.buf }
		vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float)
		vim.keymap.set('n', 'gh', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
		vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
		vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
		vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
		vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
		vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
		vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
		vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
		vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
		vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
		vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
	end
})
