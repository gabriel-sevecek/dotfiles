{pkgs, ...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    completionInit = ''
      fpath+=(${pkgs.podman}/share/zsh/site-functions)

      zstyle ':completion:*' menu select
      zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
      autoload -U compinit
      compinit
    '';
    shellAliases = {
      vim = "nvim";
      s = "kitten ssh";
      n = "nvim";
      g = "git";
      d = "docker";
      op = "lsof -i -P -n";
      ls = "eza";
      ll = "eza -l";
      la = "eza -la";
      lm = "eza -l --sort=modified";
      yrg = "rg -g \"*.yml\" -g \"*.yaml\"";
      trg = "rg -g \"*.ts\"";
      vrg = "rg -g \"*.vue\"";
    };
    history = {
      size = 1000000;
      save = 1000000;
    };
    initContent = ''
      bindkey -e
      [[ ! $(command -v nix) && -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]] && source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
    '';
    plugins = [
      {
        name = "fzf-zsh-plugin";
        src = pkgs.fetchFromGitHub {
          owner = "unixorn";
          repo = "fzf-zsh-plugin";
          rev = "480cbd0cdf1ef03b87c194c1b4c9d438b201c4fd";
          hash = "sha256-YSBOvBVfVrGO7Tr+TCXjt5KRyXxKzagg7d76SSHeJKw=";
        };
      }
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "e0165eaa730dd0fa321a6a6de74f092fe87630b0";
          hash = "sha256-4rW2N+ankAH4sA6Sa5mr9IKsdAg7WTgrmyqJ2V1vygQ=";
        };
      }
      {
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "c3d4e576c9c86eac62884bd47c01f6faed043fc5";
          hash = "sha256-B+Kz3B7d97CM/3ztpQyVkE6EfMipVF8Y4HJNfSRXHtU=";
        };
      }
      {
        name = "zsh-autopair";
        src = pkgs.fetchFromGitHub {
          owner = "hlissner";
          repo = "zsh-autopair";
          rev = "396c38a7468458ba29011f2ad4112e4fd35f78e6";
          hash = "sha256-PXHxPxFeoYXYMOC29YQKDdMnqTO0toyA7eJTSCV6PGE=";
        };
      }
    ];
  };
}
