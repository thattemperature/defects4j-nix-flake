{

  description = "Environment for defects4j.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils/main";
  };

  outputs =
    { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (
      system:

      let

        pkgs = import nixpkgs { inherit system; };

        perl-pkgs =
          ps: with ps; [
            DBDCSV
            DBI
            JSON
            JSONParse
            ListAllUtils
            PerlCritic
            StringInterpolate
            URI
          ];
        perl-env = pkgs.perl.withPackages perl-pkgs;
        java = pkgs.jdk11;
        basics = with pkgs; [
          curl
          unzip
        ];

      in

      {
        devShells.default = pkgs.mkShell {
          name = "defects4j-shell";

          buildInputs = [
            perl-env
            java
          ]
          ++ basics;

        };
      }
    );

}
