-- Neon colorscheme
return {
  'rafamadriz/neon',
  lazy = false,
  priority = 1000,
  config = function()
    vim.g.neon_style = 'default' -- default, doom, dark, light
    vim.g.neon_italic_comment = true
    vim.g.neon_italic_keyword = true
    vim.g.neon_italic_function = false
    vim.g.neon_italic_variable = false
    vim.g.neon_bold = true
    vim.g.neon_transparent = false

    vim.cmd 'colorscheme neon'
  end,
}

