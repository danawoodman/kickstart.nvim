--
-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
--
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

--
-- Remember last edit position for a file
--
local lastplace = vim.api.nvim_create_augroup("LastPlace", {})
vim.api.nvim_clear_autocmds({ group = lastplace })
vim.api.nvim_create_autocmd("BufReadPost", {
  group = lastplace,
  pattern = { "*" },
  desc = "remember last cursor place",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

--
-- Remember fold position
--
vim.api.nvim_command('augroup remember_folds')
vim.api.nvim_command('autocmd!')
vim.api.nvim_command('autocmd BufWinLeave * silent! mkview')
vim.api.nvim_command('autocmd BufWinEnter * silent! loadview')
vim.api.nvim_command('augroup END')
