{ pkgs, ... }:
{
  treefmt = {
    enable = true;
    config.programs = {
      dprint = {
        enable = true;
        includes = [ "*.scss" ];
        settings = {
          indentWidth = 2;
          useTabs = false;

          plugins = pkgs.dprint-plugins.getPluginList (
            plugins: with plugins; [
              g-plane-malva
            ]
          );

          malva = {
            hexColorLength = "short";
            quotes = "preferSingle";
            formatComments = true;
            declarationOrder = "smacss";
            keyframeSelectorNotation = "keyword";
            preferSingleLine = true;
          };
        };
      };

      kdlfmt.enable = true;
      nixfmt.enable = true;
      oxfmt.enable = true;
      rustfmt.enable = true;
      sqruff.enable = true;
      taplo.enable = true;
    };
  };
}
