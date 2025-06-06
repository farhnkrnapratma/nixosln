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
        sudo-rs
        git
        gh
        jujutsu
        evil-helix
        yazi
        zellij
        htop
        btop
        fastfetch
        zenith
        bat
        eza
        zoxide
        gitui
        ripgrep
        fd
        dust
        dua
        hyperfine
        fselect
        delta
        tokei
        wiki-tui
        just
        mask
        mprocs
        wezterm
        wofi

        # another apps
        discord
        telegram-desktop
        signal-desktop
        spotify
        libreoffice-qt-fresh
        dfilemanager

        # dev tools
        rustup
        rusty-man
        bacon
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

    programs.uwsm.enable = true;

    programs.firefox.enable = true;

    services.openssh.enable = true;

    networking.firewall = {
        enable = true;
        allowPing = false;
        trustedInterfaces = [ "wlp2s0" ];
        interfaces."wlp2s0" = {
            allowedTCPPorts = [ 22 443 993 ];
            allowedUDPPorts = [ 53 123 ];
        };
        logRefusedConnections = true;
    };

    system.stateVersion = "25.05";
}
