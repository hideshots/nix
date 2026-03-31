{ pkgs, inputs, hostname, username, ... }:

{
  imports = [
    ./hardware.nix
    ../common.nix

    ../../modules/system/sddm
    ../../modules/system/hyprland.nix
    ../../modules/system/sway.nix
  ];

  networking.hostName = hostname;

  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
  };

  nixpkgs.overlays = [ inputs.nix-cachyos-kernel.overlays.pinned ];
  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-lts;

  nix.settings = {
    substituters = [
      "https://attic.xuyh0120.win/lantian"
      "https://cache.garnix.io"
    ];
    trusted-public-keys = [
      "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
    ];
  };

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  hardware = {
    enableRedistributableFirmware = true;

    cpu.intel.updateMicrocode = true;

    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-vaapi-driver
      ];
    };
  };

  networking.networkmanager.wifi.powersave = false;

  services = {
    upower.enable = true;
    power-profiles-daemon.enable = true;

    udev.extraHwdb = ''
      evdev:atkbd:*
        KEYBOARD_KEY_3a=leftctrl
    '';
  };

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 75;
  };

  environment = {
    sessionVariables = {
      LIBVA_DRIVER_NAME = "i965";
    };

    systemPackages = with pkgs; [
      nbfc-linux
    ];

    etc."nbfc/nbfc.json".text = ''
      {
        "SelectedConfigId": "Lenovo Yoga 11s"
      }
    '';
  };

  systemd.services.nbfc_service = {
    description = "Laptop FanControl service";
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.nbfc-linux ];

    serviceConfig = {
      Type = "forking";
      PIDFile = "/run/nbfc_service.pid";
      Restart = "on-failure";
      TimeoutStopSec = 20;

      ExecStart = [
        ""
        "${pkgs.nbfc-linux}/bin/nbfc_service --fork --config-file /etc/nbfc/nbfc.json"
      ];

      ExecStop = [
        ""
        "${pkgs.nbfc-linux}/bin/nbfc stop"
      ];
    };
  };

  system.stateVersion = "25.11";
}
