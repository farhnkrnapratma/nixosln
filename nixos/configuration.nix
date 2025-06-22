{ config, pkgs, ... }:

{
    imports = [
        ./hardware-configuration.nix
    ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.kernelPackages = pkgs.linuxPackages_latest;

    security.sudo-rs = {
        enable = true;
        package = pkgs.sudo-rs;
        wheelNeedsPassword = false;
    };

    networking.hostName = "Hanz";
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
        LC_TIME = "en_US.UTF-8";
    };

    users.users.root.shell = pkgs.fish;

    users.users.farhn = {
        isNormalUser = true;
        description = "Administrator";
        extraGroups = [ "networkmanager" "wheel" "audio" "video" "input" ];
        shell = pkgs.fish;
    };

    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs; [
        git
        gh
        evil-helix
        yazi
        htop
        btop
        fastfetch
        bat
        eza
        zoxide
        gitui
        hyperfine
        tokei
        wiki-tui
        just

        # another apps
        discord
        telegram-desktop
        signal-desktop
        spotify
        libreoffice-qt-fresh
        wpsoffice
        onlyoffice-desktopeditors
        protonvpn-gui

        # dev tools
        rustup
        rust-analyzer
        rusty-man
    ];

    fonts.packages = with pkgs; [
        nerd-fonts.fira-code
        nerd-fonts.jetbrains-mono
        noto-fonts-cjk-sans
        noto-fonts-emoji-blob-bin
    ];

    # COSMIC
    services.desktopManager.cosmic = {
        enable = true;
        xwayland.enable = true;
    };

    environment.cosmic.excludePackages = with pkgs; [
        cosmic-player
        cosmic-store
    ];
    
    services.displayManager.cosmic-greeter = {
        enable = true;
        package = pkgs.cosmic-greeter;
    };

    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        wireplumber.enable = true;
    };
    
    programs.firefox.enable = true;

    services.openssh.enable = true;

    networking.firewall = {
        enable = true;
        allowPing = false;
        trustedInterfaces = [ "wlp2s0" ];
        interfaces."wlp2s0" = {
            allowedTCPPorts = [ 22 443 993 ];
            allowedUDPPorts = [ 53 123 1194 ];
        };
        logRefusedConnections = true;
    };

    system.stateVersion = "25.11";
}
