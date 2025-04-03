return {
  'akinsho/toggleterm.nvim',
  enabled = false,
  config = function ()
  require('toggleterm').setup({
    open_mapping = '<C-/>',
    terminal_mappings = true,
    direction = 'float',
    float_opts = {
      border = 'curved',
    },
  })
  end
}
