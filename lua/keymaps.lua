local M = {}
local k = vim.keymap

--
-- Comments
--
k.set({ 'n', 'v' }, '<leader>,', 'gcc', { desc = 'Toggle comments on line/selection', remap = true })
-- k.set('n', '<leader>', 'za')

--
-- Save and quit shortcuts
--
k.set('n', '<leader>w', ':w<CR>', { desc = 'Save buffer' })
k.set('n', '<leader>q', ':xa<CR>', { desc = 'Save all buffers and quit' })
k.set('n', '<leader>e', ':bd<CR>', { desc = 'Close buffer' })
k.set('n', '<leader>Q', ':q<CR>', { desc = 'Quit' })

--
-- Exit out of insert mode
--
k.set('i', 'jj', '<Esc>', { desc = 'Exit out of insert mode' })

--
-- Splits
--
k.set('n', '<leader>h', '<C-w>h', { desc = 'Go to left split' })
k.set('n', '<leader>l', '<C-w>l', { desc = 'Go to right split' })
k.set('n', '<leader>j', '<C-w>j', { desc = 'Go to lower split' })
k.set('n', '<leader>k', '<C-w>k', { desc = 'Go to upper split' })
k.set('n', '<leader>v', '<C-w>v', { desc = 'Create vertical split' })

--
-- neo-tree file navigator
--
k.set('n', '<leader>n', ':Neotree toggle<CR>', { desc = 'Create vertical split' })

--
-- Jump between previous buffers
--
k.set('n', '<leader>b', ':b#<CR>', { desc = 'Jump between previous buffers' })

--
-- Diagnostic keymaps
--
k.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
k.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
-- k.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
-- k.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

--
-- Telescope search
-- See `:help telescope.builtin`
--
k.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
k.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzy find in current buffer' })
k.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
k.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = '[F]ind [F]iles' })
k.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = '[F]ind [H]elp' })
k.set('n', '<leader>fw', require('telescope.builtin').grep_string, { desc = '[F]ind current [W]ord' })
k.set('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = '[F]ind by [G]rep' })
k.set('n', '<leader>fr', require('telescope.builtin').resume, { desc = '[F]ind [R]esume' })
k.set('n', '<leader>fb', require('telescope.builtin').buffers, { desc = '[F]ind existing [B]uffers' })
-- k.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

--
-- Remap for dealing with word wrap
--
k.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
k.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- vim.api.nvim_set_keymap('n', '<leader>m', [[<Cmd>set foldlevel=0<CR>zMzv<Cmd>set foldlevel=999<CR>]], { noremap = true, silent = true })

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
M.on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    k.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  -- Go to
  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

  -- Symbols
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- document existing key chains
require('which-key').register {
  ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
  ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
  ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
  -- ['<leader>h'] = { name = 'More git', _ = 'which_key_ignore' },
  ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
  ['<leader>f'] = { name = '[F]ind', _ = 'which_key_ignore' },
  ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
}

return {}
