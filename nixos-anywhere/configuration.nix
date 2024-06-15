{ modulesPath, config, lib, pkgs, ... }: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./disk-config.nix
  ];

  # allow unfree packages to be installed
  nixpkgs.config = {
    allowUnfree = true;
  };

  boot.loader.grub = {
    # no need to set devices, disko will add all devices that have a EF02 partition to the list already
    # devices = [ ];
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking = {
    hostName = "nixos"; # Define your hostname.
    firewall.enable = true;
  };

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # UNCOMMENT this to enable docker
  # virtualisation.docker.enable = true;

  programs.fish.enable = true;

  security.sudo.wheelNeedsPassword = false;

  services = {
    openssh = {
      enable = true;
      settings.PasswordAuthentication = false;
    };

    # UNCOMMENT this to enable headscale
    # headscale.enable = true;

    # UNCOMMENT this to enable a prometheus node exporter
    # prometheus.exporters.node.enable = true;

    # UNCOMMENT this to enable homeassistant-satellite - it's prob necessary to add more configuration here
    # homeassistant-satellite.enable = true;
  };

  environment.systemPackages = map lib.lowPrio [
    pkgs.curl
    pkgs.gitMinimal

    # UNCOMMENT the following to install these packages systemwide
    pkgs.jq
    pkgs.neovim
    pkgs.fzf
  ];

  users.users = {

    root = {
      # change this to your ssh key
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIASmQy+YhNo6spFGwNrUjtBHgQBIsCj2GjBQ8wM1KPKc"
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC6z+lz/KN0Y7vvIO7EZDQNNJ5y868Zh4XsbO4R6VeA4a/UVXkA/LzJnjezBHOMKcL6n4WdjkYBDdcOfYSpTNzASUmiz8iP64pXgKiP96xx4rECHe1oaXRtufWSFDaXARPp33u8FtcWyC1y8xBzXTac45AiRbhdR5gHNxv4qFqSmRmeobAKf2V0iDHcKE6oWhqil27vGimFvAfF4VE3m6WPWdOTF82D+TSi/vfZnEFuCZ5mzfABOHcl0NT1w8l5ukjQCxZn/r2OSR56i07npiw/P50Paw+4tM1gaFVrnEt9gPjFD7KrIj02ecl14u77OSrg26ndelbvHSgNpofYaFri1g9YydOiaJn0zfZuqRJrx4whU7zmk0JQJBYwvRefnSIcalUbgZyKwaus1jtUUKEhjQB7HGvFVgP0Uecx+qldjsfdyX40xNqqVOa/n+CagYGN38e+YziVUklnBhZBvqrB3JF4pJ7XElvLRzjT/K+jiLD20UPG31NDswdYMALjFMnncB1qsMSvPJ7Iu5/vbuK7SiUo57rJhIqSilWHAn2dYxvX4pFdDHLqbVlBwPuQhmuSip5L86b2nR1J9canZG2UV8wDizAUvsVv7JmrQrgzYAwappXKy0j0ZkEOGkXMc7jocpBGsPbZ7kRoX7yEhABi8no20ZmpAGE1nm+MagQHYw=="
      ];
    };

    # UNCOMMENT the following to enable the nixos user
    # nixos = {
    #   isNormalUser = true;
    #   shell = pkgs.fish;
    #   description = "nixos user";
    #   extraGroups = [
    #     "networkmanager"
    #     "wheel"
    #     "docker"
    #   ];
    #   openssh.authorizedKeys.keys = [
    #     "CHANGE"
    #   ];
    # };

  };

  system.stateVersion = "24.05";
}
