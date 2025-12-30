{
  description = "Home Manager configuration of silas";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-colors.url = "github:misterio77/nix-colors";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    waveforms.url = "github:liff/waveforms-flake";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nix-colors,
      nixos-hardware,
      waveforms,
      ...
    }:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true; # For things like Nvidia drivers
          nvidia.acceptLicense = true;
        };
      };

    in
    {
      homeConfigurations."silas" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [
          ./home.nix
        ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
        extraSpecialArgs = { inherit nix-colors; };
      };

      nixosConfigurations.sansa = nixpkgs.lib.nixosSystem {
        inherit pkgs;

        modules = [
          nixos-hardware.nixosModules.framework-16-7040-amd # hardware config from: https://github.com/NixOS/nixos-hardware/blob/master/flake.nix
          ./system
          ./hosts/sansa/configuration.nix
          # waveforms.nixosModule
        ];
      };
    };
}
