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
  git-hooks.hooks = {
    # set clippy settings for rust projects, but don't enable it by default in case projects don't use rust
    clippy.settings = {
      allFeatures = true;
      denyWarnings = true;
    };

    # for typescript projects
    oxlint = {
      name = "oxlint";
      description = "Uses oxlint to catch any linting errors or warnings before committing";
      entry = "oxlint --type-aware --type-check --deny-warnings";
      types_or = [
        "javascript"
        "ts"
        "json"
      ];
    };

    # hooks that can apply to all projects
    treefmt.enable = true;
    commitlint-rs = {
      enable = true;
      name = "commitlint-rs";
      package = pkgs.commitlint-rs;
      description = "Validate commit messages with commitlint-rs";
      entry = "${pkgs.lib.getExe pkgs.commitlint-rs} -g ${commitlintConfig} -e";
      pass_filenames = true;
      stages = [ "commit-msg" ];
    };
  };
}
