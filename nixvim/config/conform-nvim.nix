{
  plugins.conform-nvim = {
    enable = true;
    formattersByFt = {
      nix = ["alejandra"];
    };
    formatOnSave = {
      lspFallback = true;
      timeoutMs = 500;
    };
  };
  userCommands = {
    Format = {
      command = "lua require('conform').format()";
    };
  };
}
