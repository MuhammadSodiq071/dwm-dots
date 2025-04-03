-- :h bufferline.nvim
return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function ()
    local bufferline = require('bufferline')
    vim.opt.termguicolors = true
    bufferline.setup {
      options = {
        style_preset = bufferline.style_preset.minimal, -- or bufferline.style_preset.minimal
        -- themable = true, -- allows highlight groups to be overriden i.e. sets highlights as default
        indicator = {
            icon = '▎', -- this should be omitted if indicator style is not 'icon'
            style = 'icon' -- 'icon'/'underline'/'none'
        },
        diagnostics = "nvim_lsp", -- false/"nvim_lsp"/"coc",
        diagnostics_update_on_event = true, -- use nvim's diagnostic handler
        offsets = {
            {
                filetype = "NvimTree",
                text = "Nvim Tree", -- "..."/function
                text_align = "center", -- "left"/"center"/"right"
                separator = true
            },
        },
        color_icons = true, -- true/false whether or not to add the filetype icon highlights
        show_buffer_icons = true, -- true/false: disable filetype icons for buffers
        show_tab_indicators = true,
        separator_style = "slant", -- "slant"/"slope"/"thick"/"thin"/{ 'any', 'any' }
        diagnostics_indicator = function (count, level, diagnostics_dict, context)
          if context.buffer:current() then
            return ''
          end
          return ''
        end
      }
    }
  end,
}

