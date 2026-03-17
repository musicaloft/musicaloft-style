{ config, lib, ... }:
lib.mkIf config.languages.rust.enable {
  git-hooks.hooks.clippy = {
    enable = true;
    settings = {
      allFeatures = true;
      denyWarnings = true;
    };
  };

  treefmt.config.programs = {
    rustfmt.enable = true;
    taplo.enable = true;
  };
}
