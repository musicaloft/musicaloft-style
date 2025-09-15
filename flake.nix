{
  description = "The standardized Musicaloft code style";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } (
      { flake-parts-lib, ... }:
      let
        inherit (flake-parts-lib) importApply;
        flakeModule = importApply ./module.nix { inherit inputs; };
      in
      {
        imports = [
          inputs.flake-parts.flakeModules.flakeModules
          flakeModule
        ];
        systems = [
          "x86_64-linux"
          "aarch64-linux"
          "aarch64-darwin"
          "x86_64-darwin"
        ];
        perSystem =
          { config, ... }:
          {
            devShells.default = config.treefmt.build.devShell;
          };
        flake.flakeModule = flakeModule;
      }
    );
}
