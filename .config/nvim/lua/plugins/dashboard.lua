return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  config = function()
    require('dashboard').setup {
      theme = 'hyper',
      config = {
        header = {
          'Welcome to NeoVim!',
        },
        -- week_header = {
        --   enable = true,
        -- },
        shortcut = {
          {
            desc = '󰊳 Update',
            group = '@property',
            action = 'Lazy update',
            key = 'u'
          },
          {
            icon = ' ',
            icon_hl = '@variable',
            desc = 'Files',
            group = 'Label',
            action = 'Telescope find_files',
            key = 'f',
          },
          {
            icon = ' ',
            desc = 'Config',
            action = 'edit ~/.config/nvim/init.lua',
            key = 'c'
          }
        },
        footer = {
          '',
        },
      },
    }
  end,
  dependencies = { { 'nvim-tree/nvim-web-devicons' } }
}
