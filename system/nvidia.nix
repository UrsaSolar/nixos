{ config, ...}:
{

  # Nvidia
  hardware.nvidia-container-toolkit.enable = true;
  services.xserver.videoDrivers = ["nvidia"]; # Load nvidia driver

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  hardware.nvidia = {
    modesetting.enable = true; # Modesetting is required for Optimus 
    powerManagement.enable = true;
    open = true;
    nvidiaSettings = false; # Enable the Nvidia settings app
    package = config.boot.kernelPackages.nvidiaPackages.stable; #driver version
  };

}
