{ pkgs, ... }:
{
  projectRootFile = "flake.nix";

  programs = {
    mdformat.enable = true;
    nixfmt.enable = true;
    shellcheck.enable = true;
  };
}
