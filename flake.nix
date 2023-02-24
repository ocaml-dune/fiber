{
  description = "Piaf Nix Flake";

  inputs.nix-filter.url = "github:numtide/nix-filter";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nixpkgs.url = "github:nixos/nixpkgs";

  outputs = { self, nixpkgs, flake-utils, nix-filter }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages."${system}";
        inherit (pkgs.ocamlPackages) buildDunePackage;
      in
      rec {
        packages = rec {
          default = fiber;
          fiber = buildDunePackage {
            pname = "fiber";
            version = "n/a";
            src = ./.;
            duneVersion = "3";
            propagatedBuildInputs = with pkgs.ocamlPackages; [ dyn stdune ];
            checkInputs = with pkgs.ocamlPackages; [ ppx_inline_test ppx_expect ];
            doCheck = true;
          };
          fiber-lwt = buildDunePackage {
            pname = "fiber-lwt";
            inherit (packages.fiber) src version;
            propagatedBuildInputs = [ pkgs.ocamlPackages.lwt packages.fiber ];
            duneVersion = "3";
          };
        };
        devShells.default = pkgs.mkShell {
          inputsFrom = pkgs.lib.attrValues packages;
          buildInputs = with pkgs.ocamlPackages; [ ocaml-lsp pkgs.ocamlformat ];
        };
      });
}
