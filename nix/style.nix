# the argument to importApply. we'll use our own flake inputs here
{ inputs, flake-parts-lib, ... }:

{ ... }:
{
  # import devenv module from the root flake
  imports = [ inputs.devenv.flakeModule ];

  # flake-parts-lib must be provided here
  _module.args = { inherit flake-parts-lib; };

  perSystem =
    { ... }:
    {
      # then add musicaloft style to the default shell
      devenv.shells.default.imports = [ ../devenv/style ];
    };
}
