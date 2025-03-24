{ pkgs, ...}:{

  users.users.solarbear = {
    isNormalUser = true;
    description = "Solar Bear";
    group = "solarbear";
    extraGroups = [ "networkmanager" "wheel" "video" "libvirtd" "adbusers" ];
    shell = pkgs.zsh;
    linger = true;
  };

  users.groups.solarbear = {
    name = "solarbear";
    gid = 1000;
  };

}
