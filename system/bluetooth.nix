{ ... }:{

  hardware.bluetooth = {
    enable = true; # enables support for Bluetooth
    powerOnBoot = true; # powers up the default Bluetooth controller on boot
    settings.general = {
      enable = "Source,Sink,Media,Socket"; # Enable A2DP sink
      experimental = true; # Enables battery reporting
    };
  };


}
