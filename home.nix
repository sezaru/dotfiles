{ config, pkgs, ... }:

{
  targets.genericLinux.enable = true;

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "sezdocs";
  home.homeDirectory = "/home/sezdocs";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # Terminal
    fish


    # Chat
    signal-desktop

    feishin
    localsend

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {};

  fonts.fontconfig.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      # Disable greeting
      set fish_greeting

      # Since we don't have fish installed in the system, we workaround it by
      # calling the nix fish script explicitly
      . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish'
    '';
  };

  programs.git = {
    enable = true;
    userName = "Eduardo Barreto Alexandre";
    userEmail = "git@sezdm.com";
    aliases = {
      pu = "push";
      co = "checkout";
      cm = "commit";
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  modules = {
    compositor = {
      type = "wayland";
    };

    editors.emacs = {
      enable = true;
      default = true;

      enableElixir = true;
      enableErlang = true;
      enableWeb = true;
      enableShell = true;
      enableNix = true;
      enableRust = true;
      enableMarkdown = true;
      enableJavascript = true;
      enableJson = true;
      enableOrgMode = true;
      enableYaml = true;
      enablePython = true;
    };
  };
}
