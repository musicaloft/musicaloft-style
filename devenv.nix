{ pkgs, ... }:
{
  imports = [ ./modules ];

  # always enable nix for downstream shells
  languages.nix.enable = true;

  # hooks that apply to all projects
  git-hooks.hooks = {
    treefmt.enable = true;
    commitlint-rs = {
      enable = true;
      name = "commitlint-rs";
      package = pkgs.commitlint-rs;
      description = "Validate commit messages with commitlint-rs";
      entry = "${pkgs.lib.getExe pkgs.commitlint-rs} -e";
      pass_filenames = true;
      stages = [ "commit-msg" ];
    };
  };

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
