{ ... }:
{

  programs.ssh = {
    enable = true;
    extraConfig = ''
      PreferredAuthentications publickey,password,keyboard-interactive

      Host jupiter
        Hostname 192.168.40.13
        Port 22
        User root
        RequestTTY yes
      Host jupiter-manager
        Hostname 192.168.80.23
        Port 222
        User solarbear
        RequestTTY yes
        RemoteCommand tmux new -A -s solarbear
      Host truenas
        Hostname 192.168.40.10
        Port 222
        User superbear
        RequestTTY yes
      Host mercury
        Hostname 192.168.40.11
        Port 22
        user root
        RequestTTY yes
      Host mercury-manager
        Hostname 192.168.80.21
        Port 222
        User solarbear
        RequestTTY yes
        RemoteCommand tmux new -A -s solarbear
      Host saturn
        HostName 192.168.40.12
        Port 22
        user root
        RequestTTY yes
        StrictHostKeyChecking no
      Host mercury-manager
        Hostname 192.168.80.22
        Port 222
        User solarbear
        RequestTTY yes
        RemoteCommand tmux new -A -s solarbear
      Host saturn-gpu
        Hostname 192.168.80.24
        Port 222
        User solarbear
        RequestTTY yes
        RemoteCommand tmux new -A -s solarbear

    '';
  };  
}
