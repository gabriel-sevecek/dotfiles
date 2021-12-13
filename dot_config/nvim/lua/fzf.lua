local wk = require("which-key")

wk.register({
  f = {
    name = "FZF",
    f = { "<cmd>FZF<cr>", "Find File" },
    g = { "<cmd>GFiles<cr>", "Find Git File" },
    r = { "<cmd>Rg<cr>", "Ripgrep"},
    s = { ":Rg <C-r><C-w><cr>", "Ripgrep word under cursor"},
    l = { "<cmd>Lines<cr>", "Search in open buffers content"},
    b = { "<cmd>Buffers<cr>", "Search in open buffers names"},
    h = { "<cmd>History<cr>", "Search in history"},
  }
}, { prefix = "<leader>" })
