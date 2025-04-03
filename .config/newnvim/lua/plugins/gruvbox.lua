return {
  'luisiacc/gruvbox-baby',
  priority = 1000,
  config = function()
    vim.g.gruvbox_baby_function_style = "NONE"
    vim.g.gruvbox_baby_keyword_style = "italic"
    vim.cmd[[colorscheme gruvbox-baby]]
  end,
}

