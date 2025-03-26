{ pkgs, ...}:{

  users.users.kenglish = {
    isNormalUser = true;
    description = "Kyle English";
    group = "kenglish";
    extraGroups = [ "networkmanager" "wheel" "video" "libvirtd" "adbusers" ];
    shell = pkgs.zsh;
    linger = true;
  };

  users.groups.kenglish = {
    name = "kenglish";
    gid = 1000;
  };

}
