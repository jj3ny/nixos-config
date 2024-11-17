{ config, pkgs, lib, home-manager, ... }:

let
  user = "johnhughes";
  # Define the content of your file as a derivation
  myEmacsLauncher = pkgs.writeScript "emacs-launcher.command" ''
    #!/bin/sh
    emacsclient -c -n &
  '';
  sharedFiles = import ../shared/files.nix { inherit config pkgs; };
  additionalFiles = import ./files.nix { inherit user config pkgs; };
in
{
  imports = [
   ./dock
  ];

  # It me
  users.users.${user} = {
    name = "${user}";
    home = "/Users/${user}";
    isHidden = false;
    shell = pkgs.zsh;
  };

  homebrew = {
    enable = true;
    casks = pkgs.callPackage ./casks.nix {};
    # onActivation.cleanup = "uninstall";

    # These app IDs are from using the mas CLI app
    # mas = mac app store
    # https://github.com/mas-cli/mas
    #
    # $ nix shell nixpkgs#mas
    # $ mas search <app name>
    #
    # If you have previously added these apps to your Mac App Store profile (but not installed them on this system),
    # you may receive an error message "Redownload Unavailable with This Apple ID".
    # This message is safe to ignore. (https://github.com/dustinlyons/nixos-config/issues/83)

    # masApps = {
    #   "1password" = 1333542190;
    #   "wireguard" = 1451685025;
    # };
  };

  # Enable home-manager
  home-manager = {
    useGlobalPkgs = true;
    users.${user} = { pkgs, config, lib, ... }:{
      home = {
        enableNixpkgsReleaseCheck = false;
        packages = pkgs.callPackage ./packages.nix {};
        file = lib.mkMerge [
          sharedFiles
          additionalFiles
          { "emacs-launcher.command".source = myEmacsLauncher; }
        ];

        stateVersion = "23.11";
      };
      programs = {} // import ../shared/home-manager.nix { inherit config pkgs lib; };

      # Marked broken Oct 20, 2022 check later to remove this
      # https://github.com/nix-community/home-manager/issues/3344
      manual.manpages.enable = false;
    };
  };

  # Fully declarative dock using the latest from Nix Store
  local = { 
    dock = {
      enable = true;
      entries = [
        # { path = "/Applications/Slack.app/"; }
        { path = "/System/Applications/Mission Control.app/"; }
        { path = "/System/Applications/Launchpad.app/"; }

        # Development
        { path = "/Applications/Cursor.app/"; }
        { path = "/Applications/Nix Apps/Warp.app/"; }

        # Productivity
        { path = "/Applications/Obsidian.app/"; }
        { path = "/Applications/ChatGPT.app/"; }
        { path = "/Applications/GitHub Desktop.app/"; }

        # Browsers
        { path = "/Applications/Arc.app/"; }
        { path = "/Applications/Google Chrome.app/"; }

        # Communication & Media
        { path = "/System/Applications/Messages.app/"; }
        # { path = "/System/Applications/Facetime.app/"; }
        { path = "/System/Applications/Music.app/"; }
        { path = "/System/Applications/Sonos.app/"; }
        # { path = "/System/Applications/News.app/"; }
        #{ path = "/System/Applications/Photos.app/"; }
        # { path = "/System/Applications/Photo Booth.app/"; }
        # { path = "/System/Applications/TV.app/"; }

        # System & Devices
        # { path = "/System/Applications/Home.app/"; }
        { path = "/System/Applications/iPhone Mirroring.app/"; } # For iPhone Mirroring
        # {
        #   path = toString myEmacsLauncher;
        #   section = "others";
        # }
        # {
        #   path = "${config.users.users.${user}.home}/.local/share/";
        #   section = "others";
        #   options = "--sort name --view grid --display folder";
        # }
        {
          path = "${config.users.users.${user}.home}/downloads";
          section = "others";
          options = "--sort name --view grid --display stack";
        }
        # {
        #   path = "${config.users.users.${user}.home}/.local/share/downloads";
        #   section = "others";
        #   options = "--sort name --view grid --display stack";
        # }
      ];
    };
  };
}
