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

  elixirPkgs = with pkgs;  [
    elixir
    elixir-ls
  ];

  erlangPkgs = with pkgs; [
    erlang
    erlang-ls
  ];

  webPkgs = with pkgs; [
    html-tidy
    stylelint
    jsbeautifier
    emmet-ls
  ];

  shellPkgs = with pkgs; [
    shellcheck-minimal
    bash-language-server
  ];

  nixPkgs = with pkgs; [
    nixfmt-rfc-style
    nixd
  ];

  rustPkgs = with pkgs; [
    rustc
    cargo
    rustfmt
    rust-analyzer
  ];

  markdownPkgs = with pkgs; [
    multimarkdown
    markdownlint-cli2
  ];

  javascriptPkgs = with pkgs; [
    nodejs_22
    typescript
    typescript-language-server
  ];

  jsonPkgs = with pkgs; [
    nodePackages.vscode-json-languageserver
  ];

  orgModePkgs = with pkgs; [
    wl-clipboard-rs
    maim
  ];

  yamlPkgs = with pkgs; [
    yaml-language-server
  ];

  pythonPkgs = with pkgs: [
    isort
    pipenv
    python312Packages.pytest
    python312Packages.python-lsp-server
  ];
in
{
  options = {
    modules.editors.emacs = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "enables emacs";
      };

      enableElixir = mkOption {
        type = types.bool;
        default = false;
        description = "enables Elixir support";
      };

      enableErlang = mkOption {
        type = types.bool;
        default = false;
        description = "enables Erlang support";
      };

      enableWeb = mkOption {
        type = types.bool;
        default = false;
        description = "enables Web support";
      };

      enableShell = mkOption {
        type = types.bool;
        default = false;
        description = "enables Shell support";
      };

      enableNix = mkOption {
        type = types.bool;
        default = false;
        description = "enables Nix support";
      };

      enableRust = mkOption {
        type = types.bool;
        default = false;
        description = "enables Rust support";
      };

      enableMarkdown = mkOption {
        type = types.bool;
        default = false;
        description = "enables Markdown support";
      };

      enableJavascript = mkOption {
        type = types.bool;
        default = false;
        description = "enables Javascript support";
      };

      enableJson = mkOption {
        type = types.bool;
        default = false;
        description = "enables Json support";
      };

      enableOrgMode = mkOption {
        type = types.bool;
        default = false;
        description = "enables OrgMode support";
      };

      enableYaml = mkOption {
        type = types.bool;
        default = false;
        description = "enables Yaml support";
      };

      enablePython = mkOption {
        type = types.bool;
        default = false;
        description = "enables Python support";
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
    ]
    ++ lists.optionals cfg.enableElixir elixirPkgs
    ++ lists.optionals cfg.enableErlang elixirPkgs
    ++ lists.optionals cfg.enableWeb webPkgs
    ++ lists.optionals cfg.enableShell shellPkgs
    ++ lists.optionals cfg.enableNix nixPkgs
    ++ lists.optionals cfg.enableRust rustPkgs
    ++ lists.optionals cfg.enableMarkdown markdownPkgs
    ++ lists.optionals cfg.enableJavascript javascriptPkgs
    ++ lists.optionals cfg.enableJson jsonPkgs
    ++ lists.optionals cfg.enableOrgMode orgModePkgs
    ++ lists.optionals cfg.enableYaml yamlPkgs
    ++ lists.optionals cfg.enablePython pythonPkgs;

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
