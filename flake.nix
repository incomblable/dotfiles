{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    pre-commit-hooks.url = "github:cachix/git-hooks.nix";
    pre-commit-hooks.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      pre-commit-hooks,
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

      checks = forAllSystems (system: {
        pre-commit-check = pre-commit-hooks.lib.${system}.run {
          src = ./.;
          hooks = {
            actionlint.enable = true;
            deadnix.enable = true;
            flake-checker.enable = true;
            mdformat.enable = true;
            nixfmt-rfc-style.enable = true;
            shfmt.enable = true;
          };
        };
      });

      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.mkShell {
            inherit (self.checks.${system}.pre-commit-check) shellHook;

            name = "machines";

            buildInputs =
              with pkgs;
              [
                nixd
              ]
              ++ self.checks.${system}.pre-commit-check.enabledPackages;
          };
        }
      );

    };
}
