{
  lib,
  pkgs,
}:

let
  inherit (pkgs) python3Packages;
in
lib.packagesFromDirectoryRecursive {
  inherit (python3Packages) callPackage;
  directory = ./python-modules;
}
// {
  python-binary-memcached =
    python3Packages.callPackage ./python-modules/python-binary-memcached/package.nix
      {
        inherit (pkgs) memcached;
      };
}
