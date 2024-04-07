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

  outputs = { nixpkgs, home-manager, nixvim-config, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      homeConfigurations."gabriel" = home-manager.lib.homeManagerConfiguration
        {
          inherit pkgs;
          # Specify your home configuration modules here, for example,
          # the path to your home.nix.
          modules = [ ./home.nix ];
          extraSpecialArgs = {
            nixvim = nixvim-config.packages.${system}.default; # Passing nixvim-config
          };
        };
    };
}
