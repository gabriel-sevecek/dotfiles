{pkgs, ...}: {
  programs.git = {
    enable = true;
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
}
