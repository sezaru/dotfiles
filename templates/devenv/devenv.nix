{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

with lib;

let
  pkgs-unstable = import inputs.nixpkgs-unstable {
    system = pkgs.stdenv.system;
    config.allowUnfree = true;
  };

  state_dir = config.env.DEVENV_STATE;
in
{
  imports = [
    ./modules/elixir.nix
    ./modules/postgresql.nix
    ./modules/rust.nix
    ./modules/node.nix
    ./modules/devenv_utils.nix
  ];

  dotenv.enable = true;

  modules.elixir = {
    enable = true;
    package = pkgs-unstable.elixir;
    erlang.package = pkgs-unstable.erlang;
  };

  modules.rust = {
    enable = true;
    package = pkgs-unstable.rustc;
    cargo.package = pkgs-unstable.cargo;
    rustfmt.package = pkgs-unstable.rustfmt;
  };

  modules.postgresql = {
    enable = true;
    package = pkgs-unstable.postgresql;
    port = 5432;
    extensions = extensions: [
      extensions.postgis
      extensions.timescaledb
    ];

    defaultDatabase = "some_database";
  };

  modules.node = {
    enable = true;
    typescript.enable = true;
  };
}
