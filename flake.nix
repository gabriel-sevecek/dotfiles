{
  description = "Home Manager configuration of Gabriel Sevecek";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim.url = "git+ssh://github.com/gabriel-sevecek/nixvim";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    nixvim,
    home-manager,
    ...
  }: {
    homeConfigurations = let
      mkHomeConfiguration = {
        system,
        username,
        homeDirectory,
        extraPackages,
        extraVariables,
      }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          modules = [
            ./home.nix
            ./modules/zsh.nix
            ./modules/git.nix
            {
              home.username = username;
              home.homeDirectory = homeDirectory;
              home.packages = extraPackages;
              home.sessionVariables = extraVariables;
            }
          ];
          extraSpecialArgs = {
            nixvim = nixvim.packages.${system}.default;
            inherit system;
          };
        };
      users = {
        gabriel = {
          system = "x86_64-linux";
          username = "gabriel";
          homeDirectory = "/home/gabriel";
          extraPackages = [nixpkgs.legacyPackages."x86_64-linux".aider-chat];
          extraVariables = {};
        };
        g_sevecek = {
          system = "aarch64-darwin";
          username = "g.sevecek";
          homeDirectory = "/Users/g.sevecek";
          extraPackages = [
            import
            ./pkgs/yawsso.nix
            {inherit nixpkgs;}
            nixpkgs.legacyPackages."aarch64-darwin".awscli2
          ];
          extraVariables = {
            PGGSSENCMODE = "disable";
            NPM_AUTH_TOKEN_GITLAB =
              nixpkgs.lib.strings.trim (builtins.readFile "/Users/g.sevecek/.npm_auth_token_gitlab");
          };
        };
      };
    in
      builtins.mapAttrs (_key: userAttrs: mkHomeConfiguration userAttrs) users;
  };
}
