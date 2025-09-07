{
  lib,
  stdenv,
  makeWrapper,

  # runtime dependencies
  coreutils,
  jq,
  nix,
  nix-update,
}:

let
  runtimeDependencies = [
    coreutils
    jq
    nix
    nix-update
  ];

in
stdenv.mkDerivation {
  pname = "update";
  version = "0.0.0";
  src = ./.;

  nativeBuildInputs = [ makeWrapper ];

  propagatedBuildInputs = [
    nix-update
  ];

  installPhase = ''
    mkdir -p $out/bin
    cp nix-update.sh $out/bin/update

    wrapProgram $out/bin/update \
      --prefix PATH : $out/bin:${lib.makeBinPath runtimeDependencies}
  '';
}
