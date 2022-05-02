local wk = require("which-key")

wk.register({
  T = {
    name = "Tests",
    n = { "<cmd>TestNearest<cr>", "Run nearest test suit" },
    f = { "<cmd>TestFile<cr>", "Run all tests in the file" },
    l = { "<cmd>TestLast<cr>", "Run last ran suit" },
  }
}, { prefix = "<leader>" })
