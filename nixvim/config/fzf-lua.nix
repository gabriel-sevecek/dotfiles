{
  plugins.fzf-lua = {
    enable = true;
  };
  keymaps = [
    {
      mode = "n";
      key = "<leader>ff";
      action = "require('fzf-lua').files";
      lua = true;
      options = {
        desc = "Find File";
      };
    }
    {
      mode = "n";
      key = "<leader>fg";
      action = "require('fzf-lua').git_files";
      lua = true;
      options = {
        desc = "Find Git File";
      };
    }
    {
      mode = "n";
      key = "<leader>fr";
      action = "require('fzf-lua').grep";
      lua = true;
      options = {
        desc = "Ripgrep";
      };
    }
    {
      mode = "n";
      key = "<leader>fs";
      action = "require('fzf-lua').grep_cword";
      lua = true;
      options = {
        desc = "Ripgrep word under cursor";
      };
    }
    {
      mode = "n";
      key = "<leader>fl";
      action = "require('fzf-lua').lines";
      lua = true;
      options = {
        desc = "Search in open buffers content";
      };
    }
    {
      mode = "n";
      key = "<leader>fb";
      action = "require('fzf-lua').buffers";
      lua = true;
      options = {
        desc = "Search in open buffers names";
      };
    }
    {
      mode = "n";
      key = "<leader>fh";
      action = "require('fzf-lua').oldfiles";
      lua = true;
      options = {
        desc = "Search in opened files history";
      };
    }
  ];
}
