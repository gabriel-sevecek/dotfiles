local wk = require("which-key")

wk.register({
  r = { "<cmd>Ranger \"%:h\"<cr>", "Show ranger file explorer" }
}, { prefix = "<leader>" })
