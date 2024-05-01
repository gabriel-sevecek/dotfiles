{
  plugins.conform-nvim = {
    enable = true;
    formattersByFt = {
      haskell = ["fourmolu"];
      javascript = ["prettierd"];
      json = ["jq"];
      nix = ["alejandra"];
      python = ["black"];
      sql = ["pg_format"];
      typescript = ["prettierd"];
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
