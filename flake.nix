{
  description = "The Musicaloft standard shell and Nix templates";

  outputs =
    { self }:
    {
      templates = {
        python = {
          path = ./templates/python;
          description = "A Python template with devenv, uv, ruff, ty, and git hooks";
        };
        rust = {
          path = ./templates/rust;
          description = "A Rust nightly template with devenv, treefmt, and git hooks";
        };
      };

      defaultTemplate = self.templates.rust;
    };
}
