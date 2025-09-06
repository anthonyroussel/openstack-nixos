{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    flake-compat.url = "github:edolstra/flake-compat";
  };

  description = "OpenStack on NixOS";

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
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
      in
      {
        overlays = _: _: (import ./pkgs { inherit lib pkgs; });

        packages = flake-utils.lib.filterPackages system (
          import ./pkgs {
            inherit lib pkgs;
          }
        );
      }
    );
}
