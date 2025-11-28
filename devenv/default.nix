{ ... }:
{
  imports = [
    ./commitlint.nix
    ./treefmt.nix
  ];

  languages.nix.enable = true;
}
