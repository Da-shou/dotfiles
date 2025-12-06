local term_buf = nil;
local term_win = nil;
local last_win = nil;

function ToggleTermSplit()
	-- If terminal is already open -> close it
	if term_win and vim.api.nvim_win_is_valid(term_win) then
		vim.api.nvim_win_close(term_win, true);
		vim.api.nvim_buf_delete(term_buf, { force = true });
		term_win = nil;
		term_buf = nil;
		return
	end

	last_win = vim.api.nvim_get_current_win();

	-- Open horizontal split
	vim.cmd("botright 10split");
	term_win = vim.api.nvim_get_current_win();
	vim.cmd("terminal");
	term_buf = vim.api.nvim_get_current_buf();

	vim.api.nvim_win_set_buf(term_win, term_buf);
end

function ToggleTermFocus()
	-- If terminal is already open -> focus and save
	-- the window we came from
	if term_win and vim.api.nvim_win_is_valid(term_win) then
		-- If the we are not focused on the terminal
		if vim.api.nvim_get_current_win() ~= term_win then
			-- Save window we were at
			last_win = vim.api.nvim_get_current_win();
			-- Focus terminal
			vim.api.nvim_set_current_win(term_win);
		else
			-- Go back to the window we came from
			vim.api.nvim_set_current_win(last_win);
		end
	end
end

vim.keymap.set("n", "<leader>t", ToggleTermFocus, { desc = "Focus Terminal" });
vim.keymap.set("n", "<leader>T", ToggleTermSplit, { desc = "Toggle Terminal" });
