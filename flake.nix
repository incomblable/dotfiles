{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
    }:
    let
      forAllSystems = nixpkgs.lib.genAttrs [
        "aarch64-darwin"
        "x86_64-darwin"
        "aarch64-linux"
        "x86_64-linux"
      ];

      lib = nixpkgs.lib.extend (_: _: { } // (import ./nix/lib.nix { inherit nixpkgs; }));
    in
    {
      darwinConfigurations."odinoko" = lib.mkSystem nix-darwin.lib.darwinSystem {
        hostname = "odinoko";
        system = "aarch64-darwin";
        specialArgs = {
          inherit inputs lib self;
        };
      };

      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-tree);
    };
}
