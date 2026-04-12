vim.cmd("set expandtab")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set tabstop=2")
vim.cmd("set number")

vim.g.mapleader = " "
vim.opt.relativenumber = true
vim.diagnostic.config({ virtual_text = true })

vim.keymap.set('n', '<leader>cp', function()
  vim.fn.setreg('+', vim.fn.expand('%:p'))
end, { desc = 'Copy file path to clipboard' })

require("config.lazy")
