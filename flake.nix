{
  description = "Home Manager configuration of gabriel";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim-config.url = "./nixvim";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    nixvim-config,
    ...
  }: {
    homeConfigurations = {
      "gabriel@desktop" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        modules = [./home.nix];
        extraSpecialArgs = {
          nixvim = nixvim-config.packages."x86_64-linux".default;
          username = "gabriel";
          homeDirectory = "/home/gabriel";
        };
      };
      "darwin" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."aarch64-darwin";
        modules = [./home.nix];
        extraSpecialArgs = {
          nixvim = nixvim-config.packages.aarch64-darwin.default; # Passing nixvim-config
          username = "g.sevecek";
          homeDirectory = "/Users/g.sevecek";
        };
      };
    };
  };
}
