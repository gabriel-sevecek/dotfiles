local wk = require("which-key")

wk.register({
  x = {
    name = "Trouble",
    x = { "<cmd>TroubleToggle<cr>", "Toggle lsp diagnostics" },
  },
}, { prefix = "<leader>" })
