-- Keybinding for sourcing
vim.keymap.set('n', '<leader>o', ':update | :source %<CR>')
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)

-- Binding Esc to escape terminal and go to buffer above
vim.keymap.set('t', '<Esc>', "<C-\\><C-n>", {silent = true})

-- Choosing and searching files.
vim.keymap.set('n', '<leader>f', ":Files<CR>")
vim.keymap.set('n', '<leader>h', ":Help<CR>")
vim.keymap.set('n', '<leader>e', ":NvimTreeToggle<CR>")

-- RipGrep search in all files
vim.keymap.set('n', '<leader>rg', ":RG<CR>")

-- Listing and quitting buffers
vim.keymap.set('n', '<leader>b', ":Buffers<CR>")
vim.keymap.set('n', '<leader>q', ":bdelete<CR>")

-- Run :make command with keybind
vim.keymap.set('n', '<leader>m', ":make<CR>")

-- Toggle relative line number
vim.keymap.set('n', '<leader>lr', ":set invrelativenumber<CR>")

-- Toggle MiniDiff overlay
vim.keymap.set('n', '<leader>mdf', function () MiniDiff.toggle_overlay() end, {noremap = true, silent = true})

-- Switch to dark mode or light mode
vim.keymap.set('n', '<leader>sm', SwitchMode)

-- Toggle terminal
vim.keymap.set('n', '<leader>t', ":ToggleTerm size=12 direction=horizontal<CR>", { desc = "Toggle terminal using toggleterm.nvim", noremap = true, silent = true })

-- Switch to LazyGit
vim.keymap.set('n', '<leader>g', ":LazyGit<CR>")

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

-- Adding escape to fzf to abort search
vim.api.nvim_create_autocmd("FileType", {
  pattern = "fzf",
  callback = function()
    vim.keymap.set("t", "<Esc>", "<Esc>", { buffer = true, nowait = true })
  end,
})
