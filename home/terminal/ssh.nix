{ config, pkgs, ... }:

{

  programs.ssh = {
    enable = true;
    extraConfig = ''
Host jupiter
    HostName 192.168.80.100
    user solarbear
Host jupiter-luks
    Hostname 192.168.80.100
    Port 2222
    User root
    RequestTTY yes
    RemoteCommand cryptroot-unlock
    IdentityFile ~/.ssh/jupiter-cryptunlock
    HostKeyAlgorithms ssh-rsa
Host thebe
    HostName 192.168.80.101
    user solarbear
Host jupiterver
    HostName 192.168.80.100
    user solarbear
    RemoteCommand sed 's/[^0-9.]//g' <<< $(cat /etc/os-release | grep "VERSION_ID") && exit
Host thebever
    HostName 192.168.80.101
    user solarbear
    RemoteCommand sed 's/[^0-9.]//g' <<< $(cat /etc/os-release | grep "VERSION_ID") && exit
Host mercuryver
    HostName 192.168.30.100
    user solarbear
    RemoteCommand sed 's/[^0-9.]//g' <<< $(cat /etc/os-release | grep "VERSION_ID") && exit
    '';
  };
  
}
