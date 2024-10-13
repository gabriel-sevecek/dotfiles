{
  config,
  pkgs,
  nixvim,
  username,
  homeDirectory,
  extraVariables,
  extraPackages,
  system,
  ...
}: {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = username;
  home.homeDirectory = homeDirectory;

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
  home.packages = with pkgs;
    [
      alejandra
      black
      eza
      fd
      haskellPackages.fourmolu
      jq
      nixvim
      nodejs_20
      yarn
      pgcli
      pgformatter
      prettierd
      ripgrep
      podman-compose
      # # Adds the 'hello' command to your environment. It prints a friendly
      # # "Hello, world!" when run.
      # pkgs.hello

      # # It is sometimes useful to fine-tune packages, for example, by applying
      # # overrides. You can do that directly here, just don't forget the
      # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
      # # fonts?
      # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

      # # You can also create simple shell scripts directly inside your
      # # configuration. For example, this adds a command 'my-hello' to your
      # # environment:
      # (pkgs.writeShellScriptBin "my-hello" ''
      #   echo "Hello, ${config.home.username}!"
      # '')
    ]
    ++ extraPackages;

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
  home.sessionVariables =
    {
      EDITOR = "nvim";
    }
    // extraVariables;

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
      autoload -Uz compinit
      compinit

      zstyle ':completion:*' menu select
      zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
    '';
    shellAliases = {
      vim = "nvim";
      n = "nvim";
      g = "git";
      d = "docker";
      ls = "eza";
    };
    history = {
      size = 1000000;
      save = 1000000;
    };
    initExtra = ''
      bindkey -e
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
    diff-so-fancy.enable = true;
    userName = "Gabriel Sevecek";
    userEmail = "1851927+gabriel-sevecek@users.noreply.github.com";
    aliases = {
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
    ignores = [
      "shell.nix"
      ".envrc"
      ".env"
      ".direnv"
    ];
    extraConfig = {
      pull.rebase = true;
      init.defaultBranch = "main";
    };
  };
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    mouse = true;
    escapeTime = 0;
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "screen-256color";
    baseIndex = 1;
    extraConfig = ''
      set-option -g renumber-windows on
      set-option -sa terminal-features ',xterm-kitty:RGB'

      set-option -g history-limit 30000
      set-option -g focus-events on

      bind-key 'h' 'select-pane -L'
      bind-key 'j' 'select-pane -D'
      bind-key 'k' 'select-pane -U'
      bind-key 'l' 'select-pane -R'
      bind-key 'W' 'last-window'

      bind  %  split-window -h -c "#{pane_current_path}"
      bind '"' split-window -v -c "#{pane_current_path}"

      is_vim="ps -o state= -o comm= -t '#{pane_tty}' | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?\.?(view|n?vim?x?)(-wrapped)?(diff)?$'"

      bind-key -n 'M-h' if-shell "$is_vim" 'send-keys M-h' { if -F '#{pane_at_left}' ''' 'select-pane -L' }
      bind-key -n 'M-j' if-shell "$is_vim" 'send-keys M-j' { if -F '#{pane_at_bottom}' ''' 'select-pane -D' }
      bind-key -n 'M-k' if-shell "$is_vim" 'send-keys M-k' { if -F '#{pane_at_top}' ''' 'select-pane -U' }
      bind-key -n 'M-l' if-shell "$is_vim" 'send-keys M-l' { if -F '#{pane_at_right}' ''' 'select-pane -R' }

      bind-key -T copy-mode-vi 'M-h' if -F '#{pane_at_left}' ''' 'select-pane -L'
      bind-key -T copy-mode-vi 'M-j' if -F '#{pane_at_bottom}' ''' 'select-pane -D'
      bind-key -T copy-mode-vi 'M-k' if -F '#{pane_at_top}' ''' 'select-pane -U'
      bind-key -T copy-mode-vi 'M-l' if -F '#{pane_at_right}' ''' 'select-pane -R'

      # Nightfox theme
      # Upstream: https://github.com/edeneast/nightfox.nvim/raw/main/extra/nightfox/nightfox.tmux
      set -g mode-style "fg=#131a24,bg=#aeafb0"
      set -g message-style "fg=#131a24,bg=#aeafb0"
      set -g message-command-style "fg=#131a24,bg=#aeafb0"
      set -g pane-border-style "fg=#aeafb0"
      set -g pane-active-border-style "fg=#719cd6"
      set -g status "on"
      set -g status-justify "left"
      set -g status-style "fg=#aeafb0,bg=#131a24"
      set -g status-left-length "100"
      set -g status-right-length "100"
      set -g status-left-style NONE
      set -g status-right-style NONE
      set -g status-left "#[fg=#131a24,bg=#719cd6,bold] #S #[fg=#719cd6,bg=#131a24,nobold,nounderscore,noitalics]"
      set -g status-right "#[fg=#131a24,bg=#131a24,nobold,nounderscore,noitalics]#[fg=#719cd6,bg=#131a24] #{prefix_highlight} #[fg=#aeafb0,bg=#131a24,nobold,nounderscore,noitalics]#[fg=#131a24,bg=#aeafb0] %Y-%m-%d  %I:%M %p #[fg=#719cd6,bg=#aeafb0,nobold,nounderscore,noitalics]#[fg=#131a24,bg=#719cd6,bold] #h "
      setw -g window-status-activity-style "underscore,fg=#71839b,bg=#131a24"
      setw -g window-status-separator ""
      setw -g window-status-style "NONE,fg=#71839b,bg=#131a24"
      setw -g window-status-format "#[fg=#131a24,bg=#131a24,nobold,nounderscore,noitalics]#[default] #I  #W #F #[fg=#131a24,bg=#131a24,nobold,nounderscore,noitalics]"
      setw -g window-status-current-format "#[fg=#131a24,bg=#aeafb0,nobold,nounderscore,noitalics]#[fg=#131a24,bg=#aeafb0,bold] #I  #W #F #[fg=#aeafb0,bg=#131a24,nobold,nounderscore,noitalics]"
      # end of nightfox theme
    '';
  };
}
