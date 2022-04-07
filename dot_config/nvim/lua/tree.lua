require'neo-tree'.setup {}
local wk = require("which-key")

wk.register({
  t = {
    name = "Neotree",
    t = { "<cmd>Neotree toggle<cr>", "Toggle file tree" },
    f = { "<cmd>Neotree reveal<cr>", "Reveal current file" },
    b = { "<cmd>Neotree toggle buffers<cr>", "Toggle buffers tree" },
  }
}, { prefix = "<leader>" })
