{pkgs, ...}: {
  # Import all your configuration modules here
  imports = [
    ./barbar.nix
    ./oil.nix
    ./which-key.nix
    ./startify.nix
    ./fzf-lua.nix
    ./ftplugin.nix
    ./conform-nvim.nix
    ./yanky.nix
    ./neogit.nix
  ];
  config = {
    extraPlugins = [pkgs.vimPlugins.nightfox-nvim];
    colorscheme = "nightfox";
    plugins = {
      lualine.enable = true;
    };
    opts = {
      mouse = "a";
      tabstop = 4;
      shiftwidth = 4;
      softtabstop = 4;
      expandtab = true;
      number = true;
      relativenumber = true;
      ignorecase = true;
      smartcase = true;
      incsearch = true;
      showmatch = true;
      hlsearch = true;
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader><space>";
        action = "<cmd>nohl<CR>";
      }
    ];
  };
}
