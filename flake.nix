{
  description = "Home Manager configuration of gabriel";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
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
          ];
          extraSpecialArgs = {
            nixvim = nixvim.packages.${system}.default;
            inherit username homeDirectory extraVariables extraPackages system;
          };
        };
    in {
      "gabriel" = mkHomeConfiguration {
        system = "x86_64-linux";
        username = "gabriel";
        homeDirectory = "/home/gabriel";
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
