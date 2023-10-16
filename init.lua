vim.g.mapleader = ','
vim.g.maplocalleader = ' '

require('./dependencies').setup()
require('./config').setup()
require('./autocmd').setup()
require('./telescope').setup()
require('./treesitter').setup()
require('./mason').setup()
require('./cmp').setup()
require('./keymaps').setup()

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
