# the argument to importApply. we'll use our own flake inputs here
localFlake:

{ ... }:
{
  imports = [
    localFlake.inputs.treefmt-nix.flakeModule
  ];

  perSystem =
    { ... }:
    {
      treefmt.programs = {
        rustfmt.enable = true;
        nixfmt.enable = true;
      };
    };
}
