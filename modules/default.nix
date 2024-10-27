{ config, lib, pkgs, ... }:

{
  imports = [
    ./compositor.nix
    ./editors
  ];
}
