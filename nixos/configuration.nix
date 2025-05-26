{ config, pkgs, ... }:

{
  imports = [
      ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "Fahrezza";
  networking.networkmanager.enable = true;
  networking.nameservers = [ "1.1.1.1" "1.0.0.1" ];

  time.timeZone = "Asia/Jakarta";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "id_ID.UTF-8";
    LC_IDENTIFICATION = "id_ID.UTF-8";
    LC_MEASUREMENT = "id_ID.UTF-8";
    LC_MONETARY = "id_ID.UTF-8";
    LC_NAME = "id_ID.UTF-8";
    LC_NUMERIC = "id_ID.UTF-8";
    LC_PAPER = "id_ID.UTF-8";
    LC_TELEPHONE = "id_ID.UTF-8";
    LC_TIME = "id_ID.UTF-8";
  };

  users.users.hanz = {
    isNormalUser = true;
    description = " Fahrezza";
    extraGroups = [ "networkmanager" "wheel" "audio" "video" "input" ];
    shell = pkgs.fish;
  };

  nixpkgs.config.allowUnfree = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };
  
  environment.systemPackages = with pkgs; [
    sudo-rs    # =sudo
    git 		   # a:vcs
    gh 		     # cli for github
    jujutsu 		# :a
    evil-helix 	# =helix
    yazi 		# cli file manager
      zellij 		# =tmux
      htop 		# b:system monitor
      btop 		# :b
      fastfetch 	# :b
      zenith 		# :b
      bat 		# =cat
      eza 		# =ls
      zoxide 		# =cd
      gitui		# tui for git
      ripgrep		# =grep
      fd		# =find
      dust		# =du
      dua		# =du
      hyperfine		# =time
      fselect		# =find
      delta		# syntax highlighter for git, blame, diff, grep
      tokei		# code counter
      wiki-tui		# tui for wikipedia
      just		# c:command runner
      mask		# :c defined by a maskfile.md file
      mprocs		# :c in parallel
      wezterm		# terminal emulator
      wofi		# launcher

      # another apps
      discord
      telegram-desktop
      signal-desktop
      spotify
      libreoffice-qt-fresh
      dfilemanager

      # dev tools
      rustup
      rusty-man		# command-line viewer for rust-doc
      bacon       # background rust code checker

      # hyprland must have
      brightnessctl # brightness control
      dunst       # notification daemon
      hyprpaper   # wallpaper utility
  ];
  
  fonts.packages = with pkgs; [
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji-blob-bin
      liberation_ttf
  ];

  services.auto-cpufreq.enable = true;
  programs.fish.enable = true;
  programs.hyprland = {
       enable = true;
       portalPackage = pkgs.hyprland;
       withUWSM = true;
  };
  programs.hyprlock.enable = true;
  services.hypridle.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  programs.uwsm = {
       enable = true;
       waylandCompositors = {
            hyprland = {
                 prettyName = "Hyprland";
                 comment = "Hyprland compositor managed by UWSM";
                 binPath = "/run/current-system/sw/bin/Hyprland";

            };
       };
  };
  programs.firefox.enable = true;

  services.openssh.enable = true;

  networking.firewall = {
      enable = true;
      allowPing = false;
      trustedInterfaces = ["wlp2s0"];
      interfaces."wlp2s0" = {
          allowedTCPPorts = [ 22 443 993 ];
          allowedUDPPorts = [ 53 123 ];
      };
      logRefusedConnections = true;
  };

  system.stateVersion = "25.05";

}
