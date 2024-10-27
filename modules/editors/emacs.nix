{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.modules.editors.emacs;

  emacs =
    with pkgs;
    (emacsPackagesFor emacs29).emacsWithPackages (
      epkgs: with epkgs; [ treesit-grammars.with-all-grammars ]
    );
in
{
  options = {
    modules.editors.emacs = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "enables emacs";
      };

      default = mkOption {
        type = types.bool;
        default = false;
        description = "enables emacs";
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      emacs

      # Doom dependencies
      git
      ripgrep
      gnutls
      fd
      (pkgs.nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
    ];

    home.sessionPath = [
      "$HOME/.config/emacs/bin"
    ];

    home.sessionVariables = mkMerge [
      (mkIf cfg.default {
        EDITOR = "emacs";
      })

      ({
        EMACSDIR = "$HOME/.config/emacs";
        DOOMDIR = "$HOME/.config/doom";
      })
    ];

    home.file = {
      ".config/doom".source = emacs/doom;
    };

    home.activation = {
      helloWorld = hm.dag.entryAfter [ "installPackages" ] ''
        if ! [ -d "$HOME/.config/emacs" ]; then
          $DRY_RUN_CMD ${getExe pkgs.git} clone --depth 1 https://github.com/doomemacs/doomemacs $HOME/.config/emacs
        fi
      '';
    };
  };
}
