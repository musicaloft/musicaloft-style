{ config, lib, ... }:
lib.mkIf (config.languages.javascript.enable || config.languages.typescript.enable) (
  let
    typeFlags = lib.strings.optionalString config.languages.typescript.enable "--type-aware --type-check";
  in
  {
    git-hooks.hooks = {
      oxlint = {
        name = "oxlint";
        description = "Uses oxlint to catch any linting errors or warnings before committing";
        entry = "oxlint ${typeFlags} --deny-warnings";
        types_or = [
          "javascript"
          "ts"
          "json"
        ];
      };
    };
  }
)
