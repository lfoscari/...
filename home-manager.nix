{ config, lib, pkgs, ... }:

{
  imports = [
    <home-manager/nixos>
  ];

  home-manager.users.gg = { config, lib, pkgs, ... } : {

    # ----------------------------------------------
    # NUR

    nixpkgs.config.packageOverrides = pkgs: {
      nur = import (builtins.fetchTarball {
	    url = "https://github.com/nix-community/NUR/archive/88d8e910a513eea95c0588a76a0b3d59c22f95bf.tar.gz";
        sha256 = "08yppyrk56cjynxvzk825qzrashnd2vd7jga08p129llirjh4xfk";
      }) { inherit pkgs; };
    };


    # ----------------------------------------------
    # HOME MANAGER

    programs.home-manager.enable = true;

    # home.packages = with pkgs; [
    #   ...
    # ];

    programs.git = {
      enable = true;
      userName = "Luigi Foscari";
      userEmail = "luigi.foscari@icloud.com";
    };

    programs.firefox = {
	  enable = true;

      # Enable GnomeExtensions integration
	  enableGnomeExtensions = true;
	};

    programs.zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;

      shellAliases = {
        ":q" = "exit";
        "vim" = "nvim";
        "ocaml" = "rlwrap ocaml";
      };

      oh-my-zsh = {
        enable = true;
        # theme = "kennethreitz";
        # plugins = ["git"];
      };
    };
  };
}
