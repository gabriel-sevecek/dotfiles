{
  plugins.barbar = {
    enable = true;
  };
  keymaps = [
    {
      mode = "n";
      key = "<M-[>";
      action = "<cmd>BufferPrevious<CR>";
    }
    {
      mode = "n";
      key = "<M-]>";
      action = "<cmd>BufferNext<CR>";
    }
    {
      mode = "n";
      key = "<leader>bp";
      action = "<cmd>BufferPick<CR>";
    }
    {
      mode = "n";
      key = "<leader>bcc";
      action= "<cmd>BufferClose<CR>";
    }
    {
      mode = "n";
      key = "<leader>bco";
      action= "<cmd>BufferCloseAllButCurrent<CR>";
    }
    {
      mode = "n";
      key = "<leader>bcl";
      action= "<cmd>BufferCloseBuffersLeft<CR>";
    }
    {
      mode = "n";
      key = "<leader>bcr";
      action= "<cmd>BufferCloseBuffersRight<CR>";
    }
  ];
}
