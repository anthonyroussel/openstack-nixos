{
  lib,
  pkgs,
}:

lib.packagesFromDirectoryRecursive {
  inherit (pkgs.python3Packages) callPackage;
  directory = ./python-modules;
}
