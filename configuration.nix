# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

# I3

{ config, pkgs, callPackage, ... }:

{

  nix.settings.experimental-features = [ "nix-command" ];

  services.xserver = {
    enable = true;
    
    layout = "us,pl,ua";
    xkbOptions = "grp:alt_shift_toggle";

    desktopManager = {
      xterm.enable = false;
    };

    displayManager = {
      defaultSession = "none+i3";
    };
   
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      extraPackages = with pkgs; [
        dmenu
        i3status
        i3lock
        polybarFull
     ];
    };    
    
    libinput = {
      enable = true;
      mouse = {
        accelProfile = "flat";
      };
      touchpad = {
        accelProfile = "flat";
      }; 
    };
    
  };

  services.picom = {
  enable = true;
  
  };


  fonts.fonts = with pkgs; [
    nerdfonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
  ];
  
  fonts.fontDir.enable = true;
  
# Remove sound.enable or set it to false if you had it set previously, as sound.enable is only meant for ALSA-based configurations

# rtkit is optional but recommended
  security.rtkit.enable = true;
    services.pipewire = {
  enable = true;
  alsa.enable = true;
  alsa.support32Bit = true;
  pulse.enable = true;
  # If you want to use JACK applications, uncomment this
  #jack.enable = true;
  };

  # Bluetooth
  environment.etc = {
	  "wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
		  bluez_monitor.properties = {
			  ["bluez5.enable-sbc-xq"] = true,
			  ["bluez5.enable-msbc"] = true,
			  ["bluez5.enable-hw-volume"] = true,
			  ["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
		  }
	  '';
  };

  #Wallpapers


  #Programs
  environment.systemPackages = with pkgs; [
    ranger
    wget
    kitty
    vim
    librewolf
    mate.caja-with-extensions
    (pkgs.discord.override {
      # remove any overrides that you don't want
      withOpenASAR = false;
      withVencord = true;
    })

    neofetch
    nmap
    xclip
    feh
    sublime
    pywal
    flameshot
    neovim
    libgccjit
    killall
    pasystray
    spotify
    git
    pavucontrol
    cava
    glava
    xcolor 
    dunst
    xorg.xev
    imagemagick
  ];
  
  hardware.mwProCapture.enable = true; 
  services.avahi.enable = true;
  programs.nm-applet.enable = true;

  imports = 
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.

  boot.loader = {
    systemd-boot.enable = false;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
      useOSProber = true;
      theme = pkgs.fetchFromGitHub {
        owner = "shvchk";
        repo = "fallout-grub-theme";
        rev = "80734103d0b48d724f0928e8082b6755bd3b2078";
        sha256 = "sha256-7kvLfD6Nz4cEMrmCA9yq4enyqVyqiTkVZV5y4RyUatU=";
      };
    };
  };

  networking.hostName = "linux0id"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Warsaw";

  # Select internationalisation properties.
  i18n.defaultLocale = "uk_UA.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "uk_UA.UTF-8";
    LC_IDENTIFICATION = "uk_UA.UTF-8";
    LC_MEASUREMENT = "uk_UA.UTF-8";
    LC_MONETARY = "uk_UA.UTF-8";
    LC_NAME = "uk_UA.UTF-8";
    LC_NUMERIC = "uk_UA.UTF-8";
    LC_PAPER = "uk_UA.UTF-8";
    LC_TELEPHONE = "uk_UA.UTF-8";
    LC_TIME = "uk_UA.UTF-8";
  };


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.morok = {
    isNormalUser = true;
    description = "Morok";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?





  #Other configs
  
  home.sessionUser = {
  extraFiles = {
    ".config/test.conf".text = "Setting=value\nAnotherSetting=anotherValue";
    };
  };








}
