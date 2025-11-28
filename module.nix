# the argument to importApply. we'll use our own flake inputs here
localFlake:

{ ... }:
{
  perSystem =
    { ... }:
    {
      devenv.shells.default = {
        imports = [ ./devenv ];
      };
    };
}
