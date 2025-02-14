{
  description = "NixOS configuration with flakes";
  inputs =  {  
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixpkgs.url = "github:NixOS/nixpkgs/master";
    waveforms.url = "github:liff/waveforms-flake";
  };

  outputs = { self, nixpkgs, nixos-hardware, waveforms }: {
    nixosConfigurations.sansa = nixpkgs.lib.nixosSystem {
      modules = [
        # add your model from this list: https://github.com/NixOS/nixos-hardware/blob/master/flake.nix
        nixos-hardware.nixosModules.framework-16-7040-amd 
        ./configuration.nix
        waveforms.nixosModule
     ];
    };
  };
}
