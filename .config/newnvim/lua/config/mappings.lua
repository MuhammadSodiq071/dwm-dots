local map = vim.keymap.set

map({ 'i', 'v', 's' }, '<C-i>', '<Home>',  { desc = 'Move Beginning of line' })
map({ 'i', 'v', 's' }, '<C-a>', '<End>',   { desc = 'Move End of line'       })
map({ 'i', 'v', 's' }, '<C-h>', '<Left>',  { desc = 'Move Left'              })
map({ 'i', 'v', 's' }, '<C-l>', '<Right>', { desc = 'Move Right'             })
map({ 'i', 'v', 's' }, '<C-j>', '<Down>',  { desc = 'Move Down'              })
map({ 'i', 'v', 's' }, '<C-k>', '<Up>',    { desc = 'Move Up'                })
map({ 'i', 'v', 's' }, 'df',    '<ESC>',   { desc = 'Normal mode'            })
map({'i','v','n','s'}, '<A-z>', '<cmd>lua vim.wo.wrap = not vim.wo.wrap<cr>', { desc = 'Toggle wrap' })
map({ 'n', 'v'      }, '<C-c>', 'ggVG',    { desc = 'Select all'             })
map({ 'n', 'v'      }, ';',     ':',       { desc = 'Command mode'           })
map({ 'n', 'v'      }, ':',     ';'                                           )
map('i', '<C-o>', '<ESC>o', { desc = 'Move New line' })
map('i', '<A-;>', '();<Left><Left>', { desc = '();' })
map('n', '<C-Return>', 'o<Esc>', { desc = 'New line at end' })

-- Comment
map('n', '<leader>/', 'gcc', { desc = 'Comment Line', remap = true })
map('v', '<leader>/', 'gc',  { desc = 'Comment', remap = true })

-- NvimTree
map('n', '<A-e>', '<cmd>NvimTreeToggle<cr>', { desc = 'NvimTree Toggle'})
map('n', '<leader>e', '<cmd>NvimTreeFocus<cr>', { desc = 'NvimTree Focus' })

-- Buffer switching
map('n', '<leader>b', '<cmd>enew<cr>',    { desc = 'Buffer New'      })
map('n', '<tab>',     '<cmd>bnext<cr>',   { desc = 'Buffer Next'     })
map('n', '<S-tab>',   '<cmd>bprev<cr>',   { desc = 'Buffer Previous' })
map('n', '<leader>x', '<cmd>bdelete<cr>', { desc = 'Buffer Close'    })

-- Window management remaps
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move to Left window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move to Below window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move to Above window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move to Right window' })

map('n', '<C-A-h>', '<cmd>vertical resize +5<cr>', { desc = 'Resize window Left'  })
map('n', '<C-A-l>', '<cmd>vertical resize -5<cr>', { desc = 'Resize window Right' })
map('n', '<C-A-j>', '<cmd>resize +3<CR>',          { desc = 'Resize window Down'  })
map('n', '<C-A-k>', '<cmd>resize -3<CR>',          { desc = 'Resize window Up'    })

map('v', 'J', ':m \'>+1<CR>gv=gv', { desc = 'Move line down' })
map('v', 'K', ':m \'<-2<CR>gv=gv', { desc = 'Move line up' })

