{
  description = "PC NixOS configuration";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.11";
  };
  outputs = { self, nixpkgs }: {
    nixosConfigurations.senchou-desktop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ ./configuration.nix ];
    };
  };
}
