vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>',
	'<cmd>nohlsearch<CR>')

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev,
  { desc = 'Go to previous [d]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next,
  { desc = 'Go to next [d]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float,
  { desc = 'Show diagnostic [e]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist,
  { desc = 'Open diagnostic [q]uickfix list' })

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>',
  { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<left>',
  '<cmd>echo "Use h to move!"<CR>')
vim.keymap.set('n', '<right>',
  '<cmd>echo "Use l to move!"<CR>')
vim.keymap.set('n', '<up>',
  '<cmd>echo "Use k to move!"<CR>')
vim.keymap.set('n', '<down>',
  '<cmd>echo "Use j to move!"<CR>')

vim.keymap.set('n', '<C-h>', '<C-w><C-h>',
  { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>',
  { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>',
  { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>',
  { desc = 'Move focus to the lower window' })

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup(
    'custom-highlight-yank',
    { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.keymap.set("n", "<leader>-", "<CMD>Oil --float --preview %:p:h<CR>");
vim.keymap.set("n", "<leader>cl", function()
  local filepath = vim.fn.expand("%:.") -- Relative path
  local linenr = vim.fn.line(".")
  vim.fn.setreg("+", filepath .. ":" .. linenr)
end, { desc = "Copy file:line to clipboard" })

local term_state = { buf = nil, win = nil }

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
  command = "checktime",
})

vim.keymap.set({ "n", "t" }, "<leader>tt", function()
  if term_state.win and vim.api.nvim_win_is_valid(term_state.win) then
    vim.api.nvim_win_hide(term_state.win)
    term_state.win = nil
    return
  end

  if term_state.buf and vim.api.nvim_buf_is_valid(term_state.buf) then
    vim.cmd("botright split")
    vim.api.nvim_win_set_buf(0, term_state.buf)
  else
    vim.cmd("botright split | terminal")
    term_state.buf = vim.api.nvim_get_current_buf()
  end

  term_state.win = vim.api.nvim_get_current_win()
  vim.cmd("resize 15")
  vim.cmd("startinsert")
end, { desc = "Toggle [t]erminal" })
