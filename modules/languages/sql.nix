{ config, lib, ... }:
lib.mkIf (config.services.mysql.enable || config.services.postgres.enable) {
  treefmt.config.programs.sqruff.enable = true;
}
