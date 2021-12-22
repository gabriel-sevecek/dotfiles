require'nvim-tree'.setup {}
local wk = require("which-key")

wk.register({
  t = {
    name = "Nvim Tree",
    t = { "<cmd>NvimTreeToggle<cr>", "Toggle" },
    f = { "<cmd>NvimTreeFindFile<cr>", "Find file" },
  }
}, { prefix = "<leader>" })
