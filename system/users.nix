{ pkgs, ...}:{

  users.users.solarbear = {
    isNormalUser = true;
    description = "Solar Bear";
    extraGroups = [ "networkmanager" "wheel" "video" "libvirtd" "adbusers" ];
    shell = pkgs.zsh;
  };

}
