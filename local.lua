-- local.lua - Personal configuration overrides and customizations
-- This file is for your local tweaks that you don't want mixed with kickstart base config

local M = {}

-- Tab settings - DEATH TO TABS! 🏴‍☠️
vim.o.tabstop = 2 -- Display tabs as 2 spaces wide
vim.o.shiftwidth = 2 -- Number of spaces for each indentation level
vim.o.softtabstop = 2 -- Number of spaces for tab key in insert mode
vim.o.expandtab = true -- Convert tabs to spaces (ALWAYS!)
vim.o.smartindent = true -- Smart auto-indenting

-- Neo-tree disabled due to colorscheme conflicts

-- Custom keymaps
vim.keymap.set('n', ';', ':', { desc = 'Enter command mode' })

-- Arrow keys for window navigation
vim.keymap.set('n', '<Left>', '<C-w>h', { desc = 'Move to left window' })
vim.keymap.set('n', '<Down>', '<C-w>j', { desc = 'Move to window below' })
vim.keymap.set('n', '<Up>', '<C-w>k', { desc = 'Move to window above' })
vim.keymap.set('n', '<Right>', '<C-w>l', { desc = 'Move to right window' })

vim.keymap.set('n', '\\', '<cmd>Telescope find_files<CR>', { desc = 'Find files' })
-- vim.keymap.set('n', '<C-p>', '<cmd>Telescope find_files<CR>', { desc = 'Find files' })
vim.keymap.set('n', '|', '<cmd>vsplit<CR>', { desc = 'Vertical split' })
vim.keymap.set('n', '_', '<cmd>split<CR>', { desc = 'Horizontal split' })


-- Telescope commands
vim.keymap.set('n', '<leader>sc', '<cmd>Telescope commands<CR>', { desc = '[S]earch [C]ommands' })
vim.keymap.set('n', '<leader>sr', '<cmd>Telescope yank_history<CR>', { desc = '[S]earch [R]egisters/yanks' })

-- Reload config
vim.keymap.set('n', '<leader>r', '<cmd>source %<CR>', { desc = '[R]eload config' })

-- Auto-open Telescope find_files when starting nvim without file arguments
vim.api.nvim_create_autocmd('VimEnter', {
  group = vim.api.nvim_create_augroup('startup-telescope', { clear = true }),
  callback = function()
    -- Only open telescope if no arguments were passed and we're not in a directory with files already open
    if vim.fn.argc() == 0 and vim.fn.line2byte '$' == -1 then
      -- Small delay to ensure everything is loaded
      vim.schedule(function()
        require('telescope.builtin').find_files()
      end)
    end
  end,
})

-- Fix cursor escape sequence issues
-- This disables cursor shape changes which can cause display issues in some terminals

-- Help files open in vertical split to the right
vim.api.nvim_create_autocmd('BufWinEnter', {
  group = vim.api.nvim_create_augroup('help-vertical-split', { clear = true }),
  pattern = '*',
  callback = function()
    if vim.bo.buftype == 'help' then
      vim.cmd 'wincmd L' -- Move to right
      vim.cmd 'vert resize 95' -- Set width
    end
  end,
})

-- Auto-save on buffer modification
vim.api.nvim_create_autocmd({ 'TextChanged', 'TextChangedI' }, {
  group = vim.api.nvim_create_augroup('auto-save', { clear = true }),
  pattern = '*',
  callback = function()
    if vim.bo.modified and vim.bo.buftype == '' and vim.fn.expand('%') ~= '' then
      vim.cmd('silent! write')
    end
  end,
})

-- Add your personal config here...
-- Examples:
-- vim.o.relativenumber = true
-- vim.keymap.set('n', '<leader>x', '<cmd>!chmod +x %<CR>', { desc = 'Make file executable' })

return M
