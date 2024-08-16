{ ... }:

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
    # RemoteCommand cryptroot-unlock
    IdentityFile ~/.ssh/jupiter-cryptunlock
    HostKeyAlgorithms ssh-rsa
Host mercury
    HostName 192.168.30.100
    user solarbear
Host saturn
    HostName 192.168.80.101
    user solarbear
Host saturn-luks
    HostName 192.168.80.101
    user root
    StrictHostKeyChecking no
Host mercury-luks
    HostName 192.168.80.104
    user root
    StrictHostKeyChecking no
Host jupiterver
    HostName 192.168.80.100
    user solarbear
    RemoteCommand sed 's/[^0-9.]//g' <<< $(cat /etc/os-release | grep "VERSION_ID") && exit
Host saturnver
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
