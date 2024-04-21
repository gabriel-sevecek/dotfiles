{
  plugins.conform-nvim = {
    enable = true;
    formattersByFt = {
      nix = ["alejandra"];
      haskell = ["fourmolu"];
      typescript = ["prettierd"];
      javascript = ["prettierd"];
      json = ["jq"];
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
