{

  description = "Environment for defects4j.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { nixpkgs, ... }:

    let

      system = "x86_64-linux";
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

    in

    {
      devShells.x86_64-linux.default = pkgs.mkShell {
        name = "defects4j-shell";

        buildInputs = [
          perl-env
          java
        ];

      };
    };

}
