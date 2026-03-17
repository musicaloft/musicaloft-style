{ config, lib, ... }:
lib.mkIf config.languages.python.enable {
  git-hooks.hooks = {
    ruff.enable = true;
    ruff-format.enable = true;
    ty = {
      enable = true;
      name = "ty";
      entry = "ty check";
      types = [ "python" ];
    };
  };

  treefmt.config.programs = {
    ruff-check.enable = true;
    ruff-format.enable = true;
  };
}
