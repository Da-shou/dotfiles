local term_buf = nil
local term_win = nil

function ToggleTermSplit()
  -- If terminal is already open -> close it
  if term_win and vim.api.nvim_win_is_valid(term_win) then
    vim.api.nvim_win_close(term_win, true)
    vim.api.nvim_buf_delete(term_buf, {force = true})
    term_win = nil
    term_buf = nil
    return
  end

  -- Open horizontal split
  vim.cmd("botright 15split")
  term_win = vim.api.nvim_get_current_win()
  vim.cmd("terminal")
  term_buf = vim.api.nvim_get_current_buf()

  vim.api.nvim_win_set_buf(term_win, term_buf)
end

vim.keymap.set("n", "<leader>t", ToggleTermSplit, { desc = "Toggle Terminal" })
