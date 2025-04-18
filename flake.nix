{
  description = "W47TER Bot";

  inputs.nixpkgs = {
    type = "github";
    owner = "NixOS";
    repo = "nixpkgs";
    ref = "nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  }:
    let
      supportedSystems = [
        "x86_64-linux"
        "x86_64-darwin"
        "aarch64-linux"
        "aarch64-darwin"
      ];

      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    in {
      devShells = forAllSystems (system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        walter = pkgs.callPackage ./shell.nix { inherit pkgs; };
        default = self.devShells.${system}.walter;
      });
    };
}
