{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    flake-compat.url = "github:NixOS/flake-compat";
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };

  description = "OpenStack on NixOS";

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      treefmt-nix,
      ...
    }:
    let
      inherit (nixpkgs) lib;
    in
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          inherit (nixpkgs) lib;
          overlays = [ self.overlays.${system} ];
        };

        treefmtEval = treefmt-nix.lib.evalModule pkgs ./treefmt.nix;
      in
      {
        formatter = treefmtEval.config.build.wrapper;

        overlays = _: _: (import ./pkgs { inherit lib pkgs; });

        packages = flake-utils.lib.filterPackages system (
          import ./pkgs {
            inherit lib pkgs;
          }
        );

        tasks = flake-utils.lib.filterPackages system (
          import ./tasks {
            inherit lib pkgs;
          }
        );

        checks = self.packages.${system} // {
          formatting = treefmtEval.config.build.check self;
        };
      }
    );
}
