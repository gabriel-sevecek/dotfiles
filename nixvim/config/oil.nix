{
  plugins.oil = {
    enable = true;
  };
  keymaps = [
    {
      mode = "n";
      key = "<leader>o";
      action = "<cmd>Oil<CR>";
      options = {
      	desc = "Opens Oil file manager";
      };
    }
  ];
}
