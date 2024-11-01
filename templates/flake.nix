{
  description = "Ready-made templates for easily creating flake-driven environments";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

  outputs =
    { self, nixpkgs }:

    {
      templates = rec {
        default = devenv;

        devenv = {
          path = ./devenv;
          description = "Default devenv development environment";
        };
      };
    };
}
