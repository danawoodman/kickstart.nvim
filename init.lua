vim.g.mapleader = ','
vim.g.maplocalleader = ' '

require'custom.dependencies'.setup()
require'custom.config'.setup()
require'custom.autocmd'.setup()
require'custom.telescope'.setup()
require'custom.treesitter'.setup()
require'custom.mason'.setup()
require'custom.cmp'.setup()
require'custom.keymaps'.setup()

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
