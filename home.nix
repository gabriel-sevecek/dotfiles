{
  pkgs,
  nixvim,
  ...
}: {
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    alejandra
    black
    eza
    fd
    haskellPackages.fourmolu
    jq
    nixvim
    nodejs_20
    pgcli
    pgformatter
    pnpm
    podman
    podman-compose
    prettierd
    ripgrep
    superhtml
    yarn
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/gabriel/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = "fd --type f";
  };
  programs.zsh = {
    enable = true;
    #enableAutosuggestions = true;
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
  programs.diff-so-fancy = {
    enable = true;
    enableGitIntegration = true;
  };
  programs.starship = {
    enable = true;
  };
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
  programs.z-lua = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.git = {
    enable = true;
    #delta.enable = true;
    settings = {
      alias = {
        lg = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
        l = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative -n 10";
        dc = "diff --cached";
        dh = "diff HEAD^!";
        s = "status";
        c = "commit";
        d = "diff";
        co = "checkout";
        sw = "switch";
        b = "branch";
        p = "pull";
        r = "rebase";
      };
      user = {
        name = "Gabriel Sevecek";
        email = "1851927+gabriel-sevecek@users.noreply.github.com";
      };
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
    };
    ignores = [
      "shell.nix"
      ".envrc"
      ".env"
      ".direnv"
    ];
  };
  programs.kitty = {
    enable = true;
    shellIntegration = {
      enableZshIntegration = true;
      mode = "no-cursor";
    };
    themeFile = "Nightfox";
    font = {
      name = "JetBrainsMono Nerd Font Mono";
      size =
        if pkgs.stdenv.isDarwin
        then 18
        else 16;
    };
    settings = {
      enable_audio_bell = "no";
      cursor_shape = "block";
      scrollback_pager_history_size = 10000;
      macos_option_as_alt = "yes";
    };
    keybindings = {
      "ctrl+[" = "previous_window";
      "ctrl+]" = "next_window";
      "ctrl+shift+[" = "detach_window tab-left";
      "ctrl+shift+]" = "detach_window tab-right";
      "ctrl+shift+d" = "detach_window new-tab";
      "alt+shift+]" = "next_tab";
      "alt+shift+[" = "previous_tab";
      "ctrl+shift+z" = "toggle_layout stack";
      "f2" = "new_window_with_cwd";
    };
  };
}
