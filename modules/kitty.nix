{pkgs, ...}: {
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
