{
  plugins.neogit = {
    enable = true;
  };
  keymaps = [
    {
      mode = "n";
      key = "<leader>g";
      action = "<cmd>Neogit<CR>";
      options = {
        desc = "Neogit";
      };
    }
  ];
}
