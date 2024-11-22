{ ... }:
{

  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = [ "amdgpu" ];
  #hardware.opengl.driSupport32Bit = true;   # Renamed in 24.11
  hardware.graphics.enable32Bit = true;

}
