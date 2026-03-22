{
  config,
  lib,
  pkgs,
  ...
}:
let
  cocoa = config.lib.getInput {
    name = "cocoa";
    url = "github:muni-corn/cocoa";
    attribute = "git-hooks.hooks.cocoa-lint.enable";
    follows = [ "nixpkgs" ];
  };

  cocoaPkg = cocoa.packages.${pkgs.stdenv.system}.default;
in
{
  imports = [ ./modules ];

  # always enable nix for downstream shells
  languages.nix.enable = true;

  # hooks that apply to all projects
  git-hooks.hooks = {
    treefmt.enable = true;
    cocoa-lint = {
      enable = true;
      name = "cocoa-lint";
      package = lib.mkDefault cocoaPkg;
      description = "Validates commit messages with cocoa";
      entry = "${lib.getExe config.git-hooks.hooks.cocoa-lint.package} lint";
      pass_filenames = true;
      stages = [ "commit-msg" ];
    };
  };

  packages = [ cocoaPkg ];

  # treefmt for all projects
  treefmt = {
    enable = true;
    config.programs = {
      kdlfmt.enable = true;
      nixfmt.enable = true;

      # for formatting Markdown files
      oxfmt.enable = true;
    };
  };
}
