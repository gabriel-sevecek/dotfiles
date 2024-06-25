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
        pkgs = nixpkgs.legacyPackages.${system};
        yawsso = pkgs.python3Packages.buildPythonPackage rec {
          pname = "yawsso";
          version = "1.2.0";
          src = pkgs.python3Packages.fetchPypi {
            inherit pname version;
            sha256 = "sha256-wzJk8WUpP3A4hIowedzSTQWb1rNcghKCzwBbcNK3f3E=";
          };
          doCheck = false;
        };
      in
        mkHomeConfiguration {
          system = system;
          username = "g.sevecek";
          homeDirectory = "/Users/g.sevecek";
          extraPackages = [yawsso];
          extraVariables = {
            PGGSSENCMODE = "disable";
          };
        };
    };
  };
}
