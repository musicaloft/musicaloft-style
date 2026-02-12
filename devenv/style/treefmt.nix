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
      mdformat = {
        enable = true;
        plugins =
          p: with p; [
            mdformat-admon
            mdformat-footnote
            mdformat-frontmatter
            mdformat-gfm
            mdformat-simple-breaks
            mdformat-wikilink
          ];
        settings = {
          # don't set to 100. i know you want to. it's too much.
          wrap = 80;
          number = true;
        };
      };

      kdlfmt.enable = true;
      nixfmt.enable = true;
      rustfmt.enable = true;
      taplo.enable = true;
    };
  };
}
