require'neo-tree'.setup {
  event_handlers = {
    {
      event = "vim_buffer_enter",
      handler = function()
        if vim.bo.filetype == "neo-tree" then
          vim.cmd("setlocal nonumber")
        end
      end,
    },
  }
}
local wk = require("which-key")

wk.register({
  t = {
    name = "Neotree",
    t = { "<cmd>Neotree toggle<cr>", "Toggle file tree" },
    f = { "<cmd>Neotree reveal<cr>", "Reveal current file" },
    b = { "<cmd>Neotree toggle buffers<cr>", "Toggle buffers tree" },
  }
}, { prefix = "<leader>" })
