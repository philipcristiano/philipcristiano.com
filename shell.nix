let
  pkgs = import <nixpkgs> {};
  stdenv = pkgs.stdenv;

in stdenv.mkDerivation {
  name = "env";
  buildInputs = [
                  pkgs.gnumake
                  pkgs.erlangR21
                ];
}
