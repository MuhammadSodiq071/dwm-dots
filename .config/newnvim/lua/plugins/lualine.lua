return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup {
      options = {
        fmt = string.lower,
        icons_enabled = true,
        theme = 'gruvbox-material',
        component_separators = '',
        section_separators = { left = '', right = ''},
        -- a b c won't take the entire statusline
        always_divide_middle = true,
        -- if set to false every widnow will have its own statusnbar
        globalstatus = true,
        -- refresh time in ms
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        }
      },
      sections = {
        lualine_a = { { 'mode', separator = { left = '' } } },
        lualine_b = { 'filename', 'branch' },
        lualine_c = {  'diff', 'diagnostics' },

        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { { 'location', separator = { right = '' } } }
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {}
    }
  end
}
