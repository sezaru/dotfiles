{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

{
  options = {
    modules.compositor = {
      type = mkOption {
        type = with types; uniq str;
        default = "wayland";
      };
    };
  };
}
