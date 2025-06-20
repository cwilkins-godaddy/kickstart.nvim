return {
  {
    'gbprod/yanky.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
    },
    event = 'VeryLazy',
    config = function()
      require('yanky').setup({
        ring = {
          history_length = 100,
          storage = 'shada',
          sync_with_numbered_registers = true,
          cancel_event = 'update',
          ignore_registers = { '_' },
          update_register_on_cycle = false,
        },
        picker = {
          select = {
            action = nil, -- nil to use default put action
          },
          telescope = {
            use_default_mappings = true,
            mappings = {
              i = {
                ['<C-j>'] = 'move_selection_next',
                ['<C-k>'] = 'move_selection_previous',
              },
            },
          },
        },
        system_clipboard = {
          sync_with_ring = true,
        },
        highlight = {
          on_put = true,
          on_yank = true,
          timer = 500,
        },
        preserve_cursor_position = {
          enabled = true,
        },
      })

      -- Yanky keymaps
      vim.keymap.set({ 'n', 'x' }, 'p', '<Plug>(YankyPutAfter)')
      vim.keymap.set({ 'n', 'x' }, 'P', '<Plug>(YankyPutBefore)')
      vim.keymap.set({ 'n', 'x' }, 'gp', '<Plug>(YankyGPutAfter)')
      vim.keymap.set({ 'n', 'x' }, 'gP', '<Plug>(YankyGPutBefore)')

      -- Cycle through yank history
      vim.keymap.set('n', '<c-p>', '<Plug>(YankyCycleForward)')
      vim.keymap.set('n', '<c-n>', '<Plug>(YankyCycleBackward)')

      -- Telescope yanky integration
      require('telescope').load_extension('yank_history')
    end,
  },
}