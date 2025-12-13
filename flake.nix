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
        extraModules ? [],
        extraVariables ? {},
        extraPackages ? [],
      }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          modules = [
            ./home.nix

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
    in {
      "gabriel" = let
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system};
      in
        mkHomeConfiguration {
          system = system;
          username = "gabriel";
          homeDirectory = "/home/gabriel";
          extraPackages = [
            pkgs.aider-chat
          ];
        };
      "g.sevecek" = let
        system = "aarch64-darwin";
        homeDirectory = "/Users/g.sevecek";
        pkgs = nixpkgs.legacyPackages.${system};
        yawsso = pkgs.python3Packages.buildPythonPackage rec {
          pname = "yawsso";
          version = "1.2.1";
          src = pkgs.fetchPypi {
            inherit pname version;
            hash = "sha256-kfG8re73yxoyYJtqpkG2VHk9lWjNTIl9gG8bDLwhmfI=";
          };
          format = "pyproject";

          nativeBuildInputs = with pkgs.python3Packages; [
            setuptools
            wheel
          ];
          doCheck = false;
        };
      in
        mkHomeConfiguration {
          system = system;
          username = "g.sevecek";
          homeDirectory = homeDirectory;
          extraPackages = [
            yawsso
            pkgs.awscli2
          ];
          extraVariables = {
            PGGSSENCMODE = "disable";
            NPM_AUTH_TOKEN_GITLAB = nixpkgs.lib.strings.trim (builtins.readFile "${homeDirectory}/.npm_auth_token_gitlab");
          };
        };
    };
  };
}
