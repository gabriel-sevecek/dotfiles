{
  plugins.conform-nvim = {
    enable = true;
    formattersByFt = {
      nix = ["alejandra"];
      haskell = ["fourmolu"];
      typescript = ["prettierd" "deno_fmt"];
      javascript = ["prettierd" "deno_fmt"];
      json = ["deno_fmt"];
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
