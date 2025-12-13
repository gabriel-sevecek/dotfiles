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
  };

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
