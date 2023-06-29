{
  description = "PC NixOS configuration";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    #nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
##    hyprland = {
##      url = "github:vaxerski/Hyprland";
##      inputs.nixpkgs.follows = "nixpkgs";
##    };
  };
  outputs = { self, nixpkgs, nixos }:
    {
    nixosConfigurations.senchou-desktop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
#        hyprland.nixosModules.default
#        { programs.hyprland.enable = true ;}
                ];
    };
  };
}
