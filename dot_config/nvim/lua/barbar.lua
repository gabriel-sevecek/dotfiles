local wk = require("which-key")
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map('n', '<M-[>', ':BufferPrevious<CR>', opts)
map('n', '<M-]>', ':BufferNext<CR>', opts)

wk.register({
  b = {
    name = "Buffers",
    p = { "<cmd>BufferPick<CR>", "Pick buffer" },
    cc = { "<cmd>BufferClose<CR>", "Close current buffer" },
    co = { "<cmd>BufferCloseAllButCurrent<CR>", "Close other buffers"},
    cl = { "<cmd>BufferCloseBuffersLeft<CR>", "Close buffers to the left"},
    cr = { "<cmd>BufferCloseBuffersRight<CR>", "Close buffers to the right"},
  }
}, { prefix = "<leader>" })
