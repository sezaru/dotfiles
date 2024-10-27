{
  config,
  lib,
  pkgs,
  inputs,
  system,
  ...
}:

with lib;

let
  cfg = config.modules.internet.firefox;

in
{
  options = {
    modules.internet.firefox = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "enables firefox";
      };

      search.engines = {
        enableNixPackages = mkOption {
          type = types.bool;
          default = false;
          description = "enables Nix Packages search engine";
        };

        enableYoutube = mkOption {
          type = types.bool;
          default = false;
          description = "enables Youtube search engine";
        };

        enableSearXNG = mkOption {
          type = types.bool;
          default = false;
          description = "enables SearXNG search engine";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    programs.firefox = {
      enable = true;

      profiles.sezdocs = {
        bookmarks = [ ];

        search.engines = {
          "Nix Packages" = mkIf cfg.search.engines.enableNixPackages {
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "channel";
                    value = "unstable";
                  }
                  {
                    name = "query";
                    value = " {searchTerms}";
                  }
                ];
              }
            ];

            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };

          "Youtube" = mkIf cfg.search.engines.enableYoutube {
            urls = [
              {
                template = "https://www.youtube.com/results";
                params = [
                  {
                    name = "search_query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];

            icon = "${pkgs.fetchurl {
              url = "www.youtube.com/s/desktop/8498231a/img/favicon_144x144.png";
              sha256 = "sha256-lQ5gbLyoWCH7cgoYcy+WlFDjHGbxwB8Xz0G7AZnr9vI=";
            }}";

            definedAliases = [ "@y" ];
          };

          "SearXNG" = mkIf cfg.search.engines.enableSearXNG {
            urls = [
              {
                template = "https://search.home.sezdm.com/search";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];

            icon = "${pkgs.fetchurl {
              url = "https://search.home.sezdm.com/static/themes/simple/img/favicon.png";
              sha256 = "sha256-G/GIlx81ZJ3P5ENdmB8now3N9RwDBQ1F72AiQG1ez2E=";
            }}";

            definedAliases = [ "@s" ];
          };
        };

        search.default = "SearXNG";
        search.force = true;

        # List all available extensions:
        # nix flake show "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons"
        extensions = with inputs.firefox-addons.packages.${system}; [
          bitwarden
          ublock-origin
          sponsorblock
          darkreader
          sidebery
        ];
      };
    };
  };
}
