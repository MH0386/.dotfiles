{
  config,
  lib,
  pkgs,
  inputs,
  system,
  fh,
  pkgsStable,
  ...
}:
{
  boot = {
    blacklistedKernelModules = [
      "nouveau"
      "nvidia_drm"
      "nvidia_modeset"
      "nvidia"
    ];
  };
  # Enable CUPS to print documents.
  services.printing.enable = true;
  hardware.nvidia.prime = {
    offload = {
      enable = true;
      enableOffloadCmd = true;
    };
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };
}