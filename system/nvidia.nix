{ config, ...}:
{

  # Nvidia
  hardware.nvidia-container-toolkit.enable = true;
  services.xserver.videoDrivers = ["nvidia"]; # Load nvidia driver
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
  hardware.nvidia = {
    modesetting.enable = true; # Modesetting is required for Optimus 
    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
    # of just the bare essentials.
    powerManagement.enable = true;
    # REQUIRES SECOND GPU. Fine-grained power management. Turns off GPU when not in use. (Turing or newer).
    powerManagement.finegrained = false;
    # Use the NVidia open source kernel module (not nouveau
    # supported GPUs: https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    open = false;
    nvidiaSettings = false; # Enable the Nvidia settings app
    package = config.boot.kernelPackages.nvidiaPackages.stable; #driver version
  };

}
