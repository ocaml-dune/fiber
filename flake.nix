{
  description = "Fiber Nix Flake";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs";
  };
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages."${system}";
      in rec {
        packages = let
          buildFiber = ocamlPackages:
            ocamlPackages.buildDunePackage {
              ocaml = ocamlPackages.ocaml;
              pname = "fiber";
              version = "n/a";
              src = ./.;
              duneVersion = "3";
              propagatedBuildInputs = with ocamlPackages; [ dyn stdune ];
              checkInputs = with ocamlPackages; [
                ppx_inline_test
                ppx_bench
                core_bench
                ppx_expect
              ];
              doCheck = true;
            };
        in rec {
          default = fiber;
          fiber = buildFiber pkgs.ocamlPackages;
          fiber-lwt = pkgs.ocamlPackages.buildDunePackage {
            pname = "fiber-lwt";
            inherit (packages.fiber) src version;
            propagatedBuildInputs = [ pkgs.ocamlPackages.lwt packages.fiber ];
            duneVersion = "3";
          };
          fiber_4_08 = buildFiber pkgs.ocaml-ng.ocamlPackages_4_08;
          fiber_4_09 = buildFiber pkgs.ocaml-ng.ocamlPackages_4_09;
          fiber_4_10 = buildFiber pkgs.ocaml-ng.ocamlPackages_4_10;
          fiber_4_11 = buildFiber pkgs.ocaml-ng.ocamlPackages_4_11;
          fiber_4_12 = buildFiber pkgs.ocaml-ng.ocamlPackages_4_12;
          fiber_4_13 = buildFiber pkgs.ocaml-ng.ocamlPackages_4_13;
          fiber_4_14 = buildFiber pkgs.ocaml-ng.ocamlPackages_4_14;
          fiber_5_0 = buildFiber pkgs.ocaml-ng.ocamlPackages_5_0;
          fiber_5_1 = buildFiber pkgs.ocaml-ng.ocamlPackages_5_1;
        };
        devShells.default = pkgs.mkShell {
          buildInputs = [
            packages.fiber
            packages.fiber-lwt
            pkgs.ocamlPackages.ocaml-lsp
            pkgs.ocamlPackages.ocamlformat_0_26_1
          ];
        };
      });
}
