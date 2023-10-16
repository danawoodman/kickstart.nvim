local M = {}

function M.setup()
  local o = vim.o
  local wo = vim.wo

  -- Configure tab size
  o.shiftwidth = 2
  o.tabstop = 2
  o.softtabstop = 2

  -- Set highlight on search
  o.hlsearch = false

  -- Make line numbers default
  wo.number = true

  -- Enable mouse mode
  o.mouse = 'a'

  -- Sync clipboard between OS and Neovim.
  --  Remove this option if you want your OS clipboard to remain independent.
  --  See `:help 'clipboard'`
  o.clipboard = 'unnamedplus'

  -- Enable break indent
  o.breakindent = true

  -- Save undo history
  o.undofile = true

  -- Case-insensitive searching UNLESS \C or capital in search
  o.ignorecase = true
  o.smartcase = true

  -- Keep signcolumn on by default
  wo.signcolumn = 'yes'

  -- Decrease update time
  o.updatetime = 250
  o.timeoutlen = 300

  -- Set completeopt to have a better completion experience
  o.completeopt = 'menuone,noselect'

  -- NOTE: You should make sure your terminal supports this
  o.termguicolors = true

  -- Display whitespace characters
  o.list = true
  o.listchars = "tab:→ ,trail:~,lead:•"

  -- Folding
  --  Map <Space> to toggle folds
  o.foldmethod = 'expr'
  o.foldexpr = 'nvim_treesitter#foldexpr()'

  -- Configure neoformat (Prettier)
  -- vim.g.neoformat_try_node_exe = 1
  -- vim.b.a l = ["prettier", "eslint"]

  -- vim.api.nvim_create_autocmd('BufWritePre', '*.js Neoformat')
end

return M
