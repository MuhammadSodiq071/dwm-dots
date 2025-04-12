return {
  'akinsho/toggleterm.nvim',
  config = function()
    require('toggleterm').setup({
      open_mapping = '<A-i>',
      terminal_mappings = true,
      direction = 'float',
      float_opts = {
        border = 'curved',
      },
    })
  end
}
