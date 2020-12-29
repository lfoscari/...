{ config, pkgs, ... }:

{
  imports = [
    <nixos-hardware/lenovo/thinkpad/p53>
    ./hardware-configuration.nix
	./home-manager.nix
  ];


  # ----------------------------------------------
  # BOOTLOADER

  boot = {
    # Zen Kernel for responsiveness
    # kernelPackages = pkgs.linuxPackages_zen;

    kernelParams = [
      "quiet"
      "splash"
      "pci=noaer"
    ];

    loader = {
      grub = {
        enable = true;
        version = 2;

        # Enable EFI support for GRUB
        efiSupport = true;

        # Don't install GRUB on devices
        device = "nodev";
      };

      efi = {
        # Let the system modify EFI variables
        canTouchEfiVariables = true;

        # Set the correct mountpoint
        efiSysMountPoint = "/boot";
      };
    };

	# Splash screen
	plymouth.enable = true;
  };


  # ----------------------------------------------
  # NETWORKING

  networking = {
    # Set hostname
    hostName = "alejandro";

    # The global useDHCP flag is deprecated and explicitly set to false
    useDHCP = false;

    interfaces = {
      # Per-interface useDHCP
      wlp0s20f3.useDHCP = true;
    };

    networkmanager = {
      # Use NetworkManager
      enable = true;

      # Activate NetworkManager WiFi powersave
      wifi.powersave = true;
    };
  };


  # ----------------------------------------------
  # SYSTEM

  system = {
    # NixOS "release"
    stateVersion = "20.09";

    # Enable automatic system upgrades
    autoUpgrade.enable = true;
  };

  nix.gc = {
    # Enable automatic garbage collection
    automatic = true;

    # Time for the collection
    dates = "09:00";
  };

  # Allow nonfree software
  nixpkgs.config.allowUnfree = true;

  # Set time zone
  time.timeZone = "Europe/Rome";

  # Set default locale
  i18n.defaultLocale = "en_GB.UTF-8";

  # Use X server keymap
  console.useXkbConfig = true;

  users.users.gg = {
    isNormalUser = true;
    hashedPassword = "$6$9LlH7Voy.y2qC$Q/pvglsziQNB6fSfQvE9TfeFNdsZSHWzdRjNLqX/.8XZfFJU8J.u1mOd1ae.8kbgyBnCMUoDnK1QzbN7FQccE/";
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
      "networkmanager"
      "audio"
      "video"
      "dialout"
    ];
  };


  # ----------------------------------------------
  # HARDWARE

  hardware = {
    # Update intel microcode
    cpu.intel.updateMicrocode = true;

    # Use pulseaudio audio management
    pulseaudio.enable = true;

    # Enable brightness control with xbacklight
    acpilight.enable = true;

    # Add bluetooth hardware support
    bluetooth.enable = true;
  };

  # Enable sound
  sound.enable = true;

  # Enable CUPS print framework
  services.printing.enable = true;

  services.tlp = {
    enable = true;

	settings = {
	  START_CHARGE_TRESH_BAT0 = 67;
      STOP_CHARGE_TRESH_BAT0 = 100;
	};
  };


  # ----------------------------------------------
  # X SERVER

  services = {
    xserver = {
      # Enable the X11 server
      enable = true;

      # Set it layout for X
      layout = "it";
      xkbOptions = "eurosign:e";

      libinput = {
        # Enable touchpad
        enable = true;

        # Set natural scrolling for libinput
        naturalScrolling = true;
      };

      # Select video drivers
      # videoDrivers = [ "intel" ];
    };

    # Start picom compositor
    # picom.enable = true;
  };


  # ----------------------------------------------
  # GNOME

  services.xserver = {
    displayManager.gdm = {
      enable = true;

      # Disable laggy Wayland
      wayland = false;
    };

    desktopManager = {
	  # The chosen one
	  gnome3.enable = true;

      # Remove Xterm
      xterm.enable = false;
	};
  };

  services.gnome3 = {
    # Enable essential services for Gnome
    core-os-services.enable = true;

    # Enable Gnome utilities
    core-utilities.enable = true;

    # Add GLib network extensions
    glib-networking.enable = true;

    # Add Keyring
    gnome-keyring.enable = true;
  };

  # Remove unwanted Gnome software
  environment.gnome3.excludePackages = with pkgs.gnome3; [
    cheese
    epiphany
	geary
	totem
	gnome-clocks
    gnome-contacts
    gnome-maps
    gnome-music
    gnome-software
	gnome-todo
    gnome-weather
	gnome-characters
	gnome-photos
  ];


  # ----------------------------------------------
  # FONTS

  fonts = {
    fonts = with pkgs; [ jetbrains-mono ];

    fontconfig = {
      # Enable font antialiasing
      antialias = true;

      # Monospace font
      defaultFonts.monospace = [ "JetBrainsMono" ];
    };
  };


  # ----------------------------------------------
  # ENVIRONMENT

  # Vim as default
  programs.vim.defaultEditor = true;
  environment.variables = { EDITOR = "vim"; };

  documentation = {
	enable = false;
    nixos.enable = false;
    info.enable = false;
    doc.enable = false;
  };

# openpyxl
# pylint

  environment = {
    shellAliases = { ":q" = "exit"; };

    systemPackages = with pkgs; [
      microcodeIntel
	  gnome3.gnome-tweaks
      vscode
      git
      rxvt-unicode
      dmenu
      nodejs
      bitwarden
      bitwarden-cli
      spotify
      vlc
      powertop
      wget
      tdesktop
      discord
      unzip
	  feh
	  pywal
	  powertop
	  dropbox
	  thunderbird
	  libreoffice
	  neofetch
      texlive.combined.scheme-medium
	  python3
	];
  };
}
