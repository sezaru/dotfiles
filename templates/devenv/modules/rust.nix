{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

with lib;

let
  pkgs-unstable = import inputs.nixpkgs-unstable { system = pkgs.stdenv.system; };

  state_dir = config.env.DEVENV_STATE;

  cfg = config.modules.rust;
in
{
  options = {
    modules.rust = {
      enable = mkEnableOption "Rust development";

      package = mkOption {
        type = types.package;
        default = pkgs.rustc;
        defaultText = literalMD "pkgs.rustc";
        description = "The Rust package to use";
      };

      cargo = {
        package = mkOption {
          type = types.package;
          default = pkgs.cargo;
          defaultText = literalMD "pkgs.cargo";
          description = "The Cargo package to use";
        };
      };

      rustfmt = {
        package = mkOption {
          type = types.package;
          default = pkgs.rustfmt;
          defaultText = literalMD "pkgs.rustfmt";
          description = "The Rust Formatter package to use";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    env.CARGO_HOME = "${state_dir}/cargo";

    languages.rust = {
      enable = true;

      toolchain = {
        rustc = cfg.package;
        cargo = cfg.cargo.package;
        rustfmt = cfg.rustfmt.package;
      };
    };
  };
}
