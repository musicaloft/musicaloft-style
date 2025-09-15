# the argument to importApply. we'll use our own flake inputs here
localFlake:

{ ... }:
{
  imports = [
    localFlake.inputs.treefmt-nix.flakeModule
  ];

  perSystem =
    { config, pkgs, ... }:
    {
      devenv.shells.default = {
        packages = [ config.treefmt.build.wrapper ];

        # git hooks
        git-hooks.hooks = {
          # commit linting
          commitlint-rs =
            let
              config = pkgs.writers.writeYAML "commitlintrc.yml" {
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
                      "feat"
                      "fix"
                      "perf"
                      "refactor"
                      "style"
                      "test"
                    ];
                  };
                };
              };

            in
            {
              enable = true;
              name = "commitlint-rs";
              package = pkgs.commitlint-rs;
              description = "Validate commit messages with commitlint-rs";
              entry = "${pkgs.lib.getExe pkgs.commitlint-rs} -g ${config} -e";
              always_run = true;
              stages = [ "commit-msg" ];
            };

          # format on commit
          treefmt = {
            enable = true;
            packageOverrides.treefmt = config.treefmt.build.wrapper;
          };
        };
      };

      treefmt.programs = {
        rustfmt.enable = true;
        nixfmt.enable = true;
      };
    };
}
