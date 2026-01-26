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

          plugins = (
            pkgs.dprint-plugins.getPluginList (
              plugins: with plugins; [
                g-plane-malva
              ]
            )
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
      mdformat = {
        # enable = true;
        package = pkgs.mdformat.withPlugins (
          p: with p; [
            mdformat-frontmatter
            mdformat-tables
          ]
        );
        settings.wrap = 80;
      };

      kdlfmt.enable = true;
      nixfmt.enable = true;
      rustfmt.enable = true;
      taplo.enable = true;
    };
  };
}
