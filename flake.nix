{
  description = "PC NixOS configuration";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    dzgui-nix.url = "github:lelgenio/dzgui-nix";
    dzgui-nix.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { self, nixpkgs, nixos, dzgui-nix }:
    {
    nixosConfigurations.senchou-desktop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        dzgui-nix.nixosModules.default 
        ./configuration.nix
      ];
    };
  };
}
