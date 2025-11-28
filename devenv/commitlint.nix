{ pkgs, ... }:
let
  commitlintConfig = pkgs.writers.writeYAML "commitlintrc.yml" {
    rules = {
      description-empty.level = "error";
      description-format = {
        level = "error";
        format = "^[a-z].*$";
      };
      description-max-length = {
        level = "error";
        length = 72;
      };
      scope-max-length = {
        level = "warning";
        length = 10;
      };
      scope-empty.level = "warning";
      type = {
        level = "error";
        options = [
          "build"
          "chore"
          "ci"
          "docs"
          "dx"
          "feat"
          "fix"
          "perf"
          "refactor"
          "revert"
          "style"
          "test"
        ];
      };
    };
  };
in
{
  git-hooks.hooks.commitlint-rs = {
    enable = true;
    name = "commitlint-rs";
    package = pkgs.commitlint-rs;
    description = "Validate commit messages with commitlint-rs";
    entry = "${pkgs.lib.getExe pkgs.commitlint-rs} -g ${commitlintConfig} -e";
    pass_filenames = true;
    stages = [ "commit-msg" ];
  };
}
