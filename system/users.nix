{ pkgs, ...}:{

  users.users.solarbear = {
    isNormalUser = true;
    description = "Solar Bear";
    group = "solarbear";
    extraGroups = [ "solarbear" "networkmanager" "wheel" "video" "libvirtd" "adbusers" ];
    shell = pkgs.zsh;
  };

  users.groups.solarbear = {
    name = "solarbear";
    gid = 1000;
  };

}
