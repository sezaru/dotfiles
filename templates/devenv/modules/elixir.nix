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

  mix_dir = "${state_dir}/mix";
  hex_dir = "${state_dir}/hex";

  cfg = config.modules.elixir;
in
{
  options = {
    modules.elixir = {
      enable = mkEnableOption "Rust development";

      package = mkOption {
        type = types.package;
        default = pkgs.elixir;
        defaultText = literalMD "pkgs.elixir";
        description = "The Elixir package to use";
      };

      erlang = {
        package = mkOption {
          type = types.package;
          default = pkgs.erlang;
          defaultText = literalMD "pkgs.erlang";
          description = "The Erlang package to use";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    packages = [
      cfg.package
      cfg.erlang.package
    ];

    env.ERL_AFLAGS = "-kernel shell_history enabled -kernel shell_history_path '\"${state_dir}/erlang-history\"'";

    tasks."elixir:setup" = {
      exec = ''
        mkdir -p ${mix_dir}
        mkdir -p ${hex_dir}

        export PATH=${mix_dir}/bin:$PATH
        export PATH=${mix_dir}/escripts:$PATH
        export PATH=${hex_dir}/bin:$PATH
      '';
    };

    env.MIX_HOME = mix_dir;
    env.HEX_HOME = hex_dir;

    env.ERL_LIBS = "${hex_dir}/lib/erlang/lib";
  };
}
