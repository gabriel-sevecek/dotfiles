local wk = require("which-key")
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map('n', '<M-[>', ':BufferPrevious<CR>', opts)
map('n', '<M-]>', ':BufferNext<CR>', opts)

wk.register({
  b = {
    name = "Buffers",
    p = { "<cmd>BufferPick<CR>", "Pick buffer" },
    c = {
        name = "Close",
        c = { "<cmd>BufferClose<CR>", "Close current buffer" },
        o = { "<cmd>BufferCloseAllButCurrent<CR>", "Close other buffers"},
        l = { "<cmd>BufferCloseBuffersLeft<CR>", "Close buffers to the left"},
        r = { "<cmd>BufferCloseBuffersRight<CR>", "Close buffers to the right"},
    },
  }
}, { prefix = "<leader>" })
