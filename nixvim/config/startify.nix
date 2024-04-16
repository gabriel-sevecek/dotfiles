{
  plugins.startify = {
    enable = true;
    settings = {
      bookmarks = [
        {
          n = "~/.config/home-manager/nixvim/flake.nix";
        }
        {
          h = "~/.config/home-manager/flake.nix";
        }
      ];
      change_to_dir = false;
    };
  };
}
